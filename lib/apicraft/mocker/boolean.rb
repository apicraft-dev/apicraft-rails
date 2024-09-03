# frozen_string_literal: true

module Apicraft
  module Mocker
    # Generate fake boolean values
    class Boolean < Base
      def mock
        Faker::Boolean.boolean
      end
    end
  end
end
