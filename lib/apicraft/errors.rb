# frozen_string_literal: true

module Apicraft
  class Errors
    class RouteNotFound < StandardError; end
    class InvalidContractsPath < StandardError; end
  end
end
