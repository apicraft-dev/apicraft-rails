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
      max_allowed_delay: 30,
      request_validation: {
        enabled: true,
        http_code: 400,
        response_body: proc { |ex| { message: ex.message } }
      }
    }.with_indifferent_access

    def initialize
      @opts = DEFAULTS
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

    def request_validation
      @opts[:request_validation]
    end

    def request_validation_enabled?
      @opts[:request_validation][:enabled]
    end

    def request_validation_http_code
      @opts[:request_validation][:http_code] || DEFAULTS[:request_validation][:http_code]
    end

    def request_validation_response_body
      @opts[:request_validation][:response_body]
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

    def request_validation=(request_validation_opts)
      @opts[:request_validation] = @opts[:request_validation].merge(
        request_validation_opts.with_indifferent_access
      )
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
