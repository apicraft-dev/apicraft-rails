# frozen_string_literal: true

module Apicraft
  module Mocker
    # Base class for generating fake
    # values for different data types.
    # Check subclasses
    class Base
      attr_accessor :schema

      def initialize(schema)
        @schema = schema
      end
    end
  end
end
