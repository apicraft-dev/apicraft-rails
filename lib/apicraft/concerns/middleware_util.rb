# frozen_string_literal: true

module Apicraft
  module Concerns
    # Helper class with shared methods
    module MiddlewareUtil
      def config
        @config ||= Apicraft.config
      end

      def convertor(format)
        return if format.blank?

        Apicraft::Constants::MIME_TYPE_CONVERTORS[format]
      end
    end
  end
end
