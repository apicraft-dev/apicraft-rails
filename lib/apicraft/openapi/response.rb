# frozen_string_literal: true

module Apicraft
  module Openapi
    # Represents an OpenAPI response.
    class Response
      attr_accessor :response

      def initialize(response)
        @response = response
      end

      def description
        response.description
      end

      def default_content_type
        return if content.blank?

        content.keys[0]
      end

      def content
        response.content
      end

      def content_for(content_type = nil)
        return if content.blank?

        content[content_type || default_content_type]
      end

      def schema_for(content_type = nil)
        content_for(content_type || default_content_type)&.schema
      end

      def mock(content_type = nil)
        [
          Mocker.mock(
            schema_for(content_type || default_content_type)
          ),
          content_type || default_content_type
        ]
      end
    end
  end
end
