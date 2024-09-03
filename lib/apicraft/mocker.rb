# frozen_string_literal: true

require_relative "mocker/base"
require_relative "mocker/boolean"
require_relative "mocker/string"
require_relative "mocker/number"
require_relative "mocker/integer"
require_relative "mocker/object"
require_relative "mocker/array"
require_relative "mocker/one_of"
require_relative "mocker/all_of"
require_relative "mocker/any_of"

module Apicraft
  # Namespace module for Mocker types
  module Mocker
    def self.handler_for(schema)
      "Apicraft::Mocker::#{
        extract_type(schema).camelize
      }".constantize
    end

    def self.mock(schema)
      handler_for(schema).new(
        schema
      ).mock
    end

    def self.extract_type(schema)
      return schema.type if schema.type.present?

      return "one_of" if schema.one_of.present?

      return "any_of" if schema.any_of.present?

      "all_of" if schema.all_of.present?
    end
  end
end
