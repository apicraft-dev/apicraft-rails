# frozen_string_literal: true

module Apicraft
  module Mocker
    # Generate mock based on the OneOf schema
    class OneOf < Base
      def mock
        Mocker.mock(
          schema.one_of.sample
        )
      end
    end
  end
end
