# frozen_string_literal: true

module Apicraft
  module Mocker
    # Generate an array based on the schema
    # using Mocker types
    class Array < Base
      def mock
        ::Array.new(
          (min_items..max_items)
          .to_a
          .sample
        ).map do |_i|
          Mocker.mock(schema.items)
        end
      end

      private

      def max_items
        schema.maxItems || 25
      end

      def min_items
        schema.minItems || 1
      end

      def unique_items
        schema.uniqueItems.present?
      end
    end
  end
end
