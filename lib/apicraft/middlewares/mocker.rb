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
        return @app.call(env) unless mock?(request)

        use_delay!(request)
        contract = find_contract!(request)
        operation = find_operation!(contract, request)

        code = request.headers[config.headers[:response_code]] || "200"
        response = operation.response_for(code.to_s)
        raise Errors::InvalidResponse if response.blank?

        # Determine the format passed in the request.
        # If passed we use it and the response format.
        # If not we use the first format from the specs.
        request.format.to_s
        # indicates that not format was specified.
        format = nil

        content, content_type = response.mock(format)

        [
          code.to_i,
          {
            'Content-Type': content_type
          },
          [
            content&.send(convertor(content_type))
          ].compact
        ]
      end

      private

      def config
        @config ||= Apicraft.config
      end

      def convertor(format)
        return if format.blank?

        Apicraft::Constants::MIME_TYPE_CONVERTORS[format]
      end

      def mock?(request)
        request.headers[config.headers[:mock]].present?
      end

      def find_contract!(request)
        contract = Apicraft::Openapi::Contract.find_by_operation(
          request.method, request.path_info
        )
        raise Errors::InvalidContract if c.blank?

        contract
      end

      def find_operation!(contract, request)
        operation = contract.operation(
          request.method, request.path_info
        )
        raise Errors::InvalidOperation if operation.blank?

        operation
      end

      def use_delay!(request)
        request_delay = delay(request)
        raise Errors::DelayTooHigh if request_delay > max_allowed_delay

        sleep(request_delay)
      end

      def delay(request)
        request.headers[config.headers[:delay]].to_i
      end
    end
  end
end
