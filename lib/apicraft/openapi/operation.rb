# frozen_string_literal: true

module Apicraft
  module Openapi
    # Represents an OpenAPI operation.
    # like GET /pets
    class Operation
      attr_accessor :operation

      def initialize(operation)
        @operation = operation
        @operation_object = operation.operation_object
      end

      def responses
        @operation_object.responses
      end

      def summary
        @operation_object.summary
      end

      def response_for(code)
        response = responses.response[code.to_s]
        return unless response.present?

        Response.new(
          response
        )
      end

      def raw_schema
        operation_object.raw_schema
      end

      def validate_request_body(content_type, body)
        operation.validate_request_body(
          content_type,
          body
        )
      end
    end
  end
end
