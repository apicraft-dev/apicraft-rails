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
        response_code: "Apicraft-Response-Code",
        introspect: "Apicraft-Introspect",
        mock: "Apicraft-Mock",
        delay: "Apicraft-Delay",
        content_type: "Content-Type"
      },
      mocks: true,
      introspection: true,
      strict_reference_validation: true,
      request_validations: true,
      max_allowed_delay: 30
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

    def introspection
      @opts[:introspection]
    end

    def max_allowed_delay
      @opts[:max_allowed_delay]
    end

    def contracts_path=(contracts_path)
      @opts[:contracts_path] = contracts_path
    end

    def mocks=(enabled)
      @opts[:mocks] = enabled
    end

    def introspection=(enabled)
      @opts[:introspection] = enabled
    end

    def strict_reference_validation=(enabled)
      @opts[:strict_reference_validation] = enabled
    end

    def request_validations=(enabled)
      @opts[:request_validations] = enabled
    end

    def max_allowed_delay=(enabled)
      @opts[:max_allowed_delay] = enabled
    end

    def headers=(headers)
      @opts[:headers] = @opts[:headers].merge(
        headers.with_indifferent_access
      )
    end
  end
end
