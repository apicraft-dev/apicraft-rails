# frozen_string_literal: true

require "find"
require "rack"
require "rails/railtie"
require "openapi_parser"
require "active_support"
require "active_support/core_ext"
require "faker"
require "mime/types"
require "erb"

require_relative "apicraft/version"
require_relative "apicraft/constants"
require_relative "apicraft/config"
require_relative "apicraft/concerns"
require_relative "apicraft/errors"

require_relative "apicraft/mocker"
require_relative "apicraft/openapi"

require_relative "apicraft/loader"
require_relative "apicraft/railtie"

require_relative "apicraft/web"
require_relative "apicraft/middlewares"

# Check README.md
module Apicraft
  def self.configure
    yield(config)
  end

  def self.config
    @config ||= Config.new
  end
end
