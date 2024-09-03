# frozen_string_literal: true

module Apicraft
  module Mocker
    # Generate fake values for integers
    class Integer < Number
      def mock
        super.to_i
      end
    end
  end
end
