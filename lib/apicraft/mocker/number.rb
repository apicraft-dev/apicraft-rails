# frozen_string_literal: true

module Apicraft
  module Mocker
    # Generate fake values for numbers
    class Number < Base
      def mock
        return enum.sample if enum.present?

        Faker::Number.between(
          from: schema.minimum || 1,
          to: schema.maximum || 100
        ) * multiple_of
      end

      private

      def minimum
        schema.minimum || 1
      end

      def maximum
        schema.maximum || 100
      end

      def exclusive_minimum
        schema.exclusiveMinimum
      end

      def exclusive_maximum
        schema.exclusiveMaximum
      end

      def multiple_of
        schema.multipleOf || 1
      end

      def enum
        schema.enum || []
      end
    end
  end
end
