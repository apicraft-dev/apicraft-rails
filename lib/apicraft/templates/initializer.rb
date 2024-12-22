# frozen_string_literal: true

Apicraft::Web::App.use do |user, password|
  [user, password] == %w[admin password]
end

Apicraft.configure do |config|
  config.contracts_path = Rails.root.join("app", "contracts")

  # Enables or disables the mocking features
  # Defaults to true
  config.mocks = true

  # Enables or disables the introspection features
  # Defaults to true
  config.introspection = true

  # allows you to enforce stricter validation of $ref
  # references in your OpenAPI specifications.
  # When this option is enabled, the parser will raise
  # an error if any $ref references in your OpenAPI
  # document are invalid, ensuring that all references
  # are correctly defined and resolved.
  # Defaults to true
  config.strict_reference_validation = true

  # When simulating delay using the mocks, the max
  # delay in seconds that can be simulated
  config.max_allowed_delay = 0

  config.headers = {
    # The name of the header used to control
    # the response code of the mock
    # Defaults to Apicraft-Response-Code
    response_code: "Apicraft-Response-Code",

    # The name of the header to introspect the API.
    # Defaults to Apicraft-Introspect
    introspect: "Apicraft-Introspect",

    # The name of the header to mock the API.
    # Defaults to Apicraft-Mock
    mock: "Apicraft-Mock",

    # Delay simulation header name
    delay: "Apicraft-Delay"
  }

  config.request_validation = {
    enabled: true,

    # Return the http code for validation errors, defaults to 400
    http_code: 400,

    # Return a custom response body, defaults to `{ message: "..." }`
    response_body: proc do |ex|
      {
        message: ex.message
      }
    end
  }
end
