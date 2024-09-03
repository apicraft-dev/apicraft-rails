# frozen_string_literal: true

module Apicraft
  module Openapi
    # Represents an OpenAPI operation.
    # like GET /pets
    class Operation
      attr_accessor :operation

      def initialize(operation)
        @operation = operation.operation_object
      end

      def responses
        @operation.responses
      end

      def response_for(code)
        Response.new(
          responses.response[code.to_s]
        )
      end

      def raw_schema
        operation.raw_schema
      end
    end
  end
end
