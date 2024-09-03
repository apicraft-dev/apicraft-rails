# frozen_string_literal: true

module Apicraft
  module Mocker
    # Generate fake values for string data types
    class String < Base
      def mock
        return enum.sample if enum.present?

        return Faker::Internet.email if format == "email"

        return Faker::Internet.url if format == "uri"

        return Faker::Internet.uuid if format == "uuid"

        return Faker::Time.backward.iso8601 if format == "date-time"

        Faker::Lorem.word
      end

      private

      def format
        schema.format
      end

      def min_length
        schema.minLength
      end

      def max_length
        schema.maxLength
      end

      def pattern
        schema.pattern
      end

      def enum
        schema.enum || []
      end
    end
  end
end
