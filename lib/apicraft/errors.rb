# frozen_string_literal: true

module Apicraft
  class Errors
    class RouteNotFound < StandardError; end
    class InvalidContractsPath < StandardError; end
    class InvalidContract < StandardError; end
    class InvalidOperation < StandardError; end
    class InvalidResponse < StandardError; end
  end
end
