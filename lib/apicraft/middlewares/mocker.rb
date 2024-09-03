# frozen_string_literal: true

module Apicraft
  module Middlewares
    # Apicraft Middleware to handle routing
    # and make mock calls available.
    class Mocker
      def initialize(app)
        @app = app
      end

      def call(env)
        return @app.call(env) unless config.mocks

        request = ActionDispatch::Request.new(env)
        return @app.call(env) if route_defined_in_rails?(request)

        contract = Apicraft::Openapi::Contract.find_by_operation(
          request.method, request.path_info
        )
        return @app.call(env) if contract.blank?

        operation = contract.operation(
          request.method, request.path_info
        )
        return @app.call(env) if operation.blank?

        code = request.headers[config.headers[:response_code]] || "200"
        response = operation.response_for(code.to_s)
        return @app.call(env) if response.blank?

        # Determine the format passed in the request.
        # If passed we use it and the response format.
        # If not we use the first format from the specs.
        request.format.to_s
        # indicates that not format was specified.
        format = nil

        content, content_type = response.mock(format)
        return @app.call(env) if content.blank?

        [
          code.to_i,
          { 'Content-Type': content_type },
          [content.send(convertor(content_type))]
        ]
      end

      private

      def route_defined_in_rails?(request)
        Rails.application.routes.recognize_path(
          request.path_info,
          method: request.request_method
        )
        true
      rescue ActionController::RoutingError => e
        @ex = e
        false
      end

      def config
        @config ||= Apicraft.config
      end

      def convertor(format)
        Apicraft::Constants::MIME_TYPE_CONVERTORS[format]
      end
    end
  end
end
