# frozen_string_literal: true

module Apicraft
  module Mocker
    # Generate mock based on the AnyOf schema
    class AnyOf < Base
      def mock
        num = schema.any_of.size.times.to_a.sample

        # Pick a random number of schemas
        # to build the response off of
        res = schema.any_of.sample(num + 1).map do |s|
          Mocker.mock(s)
        end
        type = res[0].class

        # TODO: This is not an accurate implementation
        # especially when it comes to numbers and strings
        # Ideally, we would want to combine rules from
        # all the schemas and then generate a value.
        if type.is_a?(Hash)
          res.reduce(&:merge)
        elsif type.is_a?(Array)
          res.reduce(&:concat)
        else
          res.sample
        end
      end
    end
  end
end
