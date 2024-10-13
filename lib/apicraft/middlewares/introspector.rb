# frozen_string_literal: true

module Apicraft
  module Middlewares
    # Apicraft Middleware to handle API Introspection.
    class Introspector
      include Concerns::MiddlewareUtil

      def initialize(app)
        @app = app
      end

      def call(env)
        return @app.call(env) unless config.introspection

        request = ActionDispatch::Request.new(env)
        return @app.call(env) unless introspect?(request)

        schema = Apicraft::Openapi::Contract.find_by_operation(
          request.method, request.path_info
        )&.operation(
          request.method, request.path_info
        )&.raw_schema
        return @app.call(env) if schema.blank?

        [
          200,
          { "Content-Type" => "application/json" },
          [schema.to_json]
        ]
      end

      private

      def introspect?(request)
        request.headers[config.headers[:introspect]].present?
      end
    end
  end
end
