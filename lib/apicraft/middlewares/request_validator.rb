# frozen_string_literal: true

module Apicraft
  module Middlewares
    # Middleware to handle Request Validation.
    class RequestValidator
      include Concerns::MiddlewareUtil

      def initialize(app)
        @app = app
      end

      def call(env)
        return @app.call(env) unless validate?

        request = ActionDispatch::Request.new(env)
        content_type = request.content_type

        operation = Apicraft::Openapi::Contract.find_by_operation(
          request.method, request.path_info
        )&.operation(
          request.method, request.path_info
        )
        return @app.call(env) if operation.blank?

        operation.validate_request_body(
          content_type,
          request.params
        )
        @app.call(env)
      rescue OpenAPIParser::OpenAPIError => e
        [
          config.request_validation_http_code,
          { 'Content-Type': content_type },
          [
            response_body(e)&.send(convertor(content_type))
          ].compact
        ]
      end

      private

      def validate?
        config.request_validation_enabled?
      end

      def response_body(ex)
        config.request_validation_response_body.call(ex)
      end
    end
  end
end
