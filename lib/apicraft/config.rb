# frozen_string_literal: true

module Apicraft
  # Configuration class for Apicraft.
  #
  # This class provides a simple way to configure Apicraft's behavior.
  # It uses a hash-based configuration system, where default values can be
  # overridden by user-provided options.
  class Config
    DEFAULTS = {
      contracts_path: nil,
      headers: {
        response_code: "Apicraft-ResponseCode",
        content_type: "Content-Type"
      },
      mocks: true,
      strict_reference_validation: true,
      request_validations: true
    }.with_indifferent_access

    def initialize(opts = {})
      @opts = DEFAULTS.merge(
        opts
      ).with_indifferent_access
    end

    def headers
      @opts[:headers]
    end

    def strict_reference_validation
      @opts[:strict_reference_validation]
    end

    def contracts_path
      @opts[:contracts_path]
    end

    def mocks
      @opts[:mocks]
    end

    def contracts_path=(contracts_path)
      @opts[:contracts_path] = contracts_path
    end

    def mocks=(enabled)
      @opts[:mocks] = enabled
    end

    def strict_reference_validation=(enabled)
      @opts[:strict_reference_validation] = enabled
    end

    def request_validations=(enabled)
      @opts[:request_validations] = enabled
    end
  end
end
