# frozen_string_literal: true

module Apicraft
  module Mocker
    # Generate an object based on the schema
    # using Mocker types
    class Object < Base
      def mock
        res = {}
        properties.each do |k, v|
          res[k] = Mocker.mock(v)
        end
        res
      end

      private

      def required
        schema.required || []
      end

      def min_properties
        schema.minProperties || 0
      end

      def max_properties
        schema.maxProperties || 0
      end

      def properties
        schema.properties || {}
      end
    end
  end
end
