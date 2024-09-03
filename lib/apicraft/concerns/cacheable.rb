# frozen_string_literal: true

module Apicraft
  module Concerns
    # Simple cache structure to not
    # fetch the same data multiple times
    # from the contracts
    module Cacheable
      @cache = {
        key: {
          loaded: true,
          content: {}
        }
      }.with_indifferent_access

      def self.cache
        @cache
      end

      def with_cache(key)
        data = Cacheable.cache[key]
        return data[:content] if data.present?

        c = yield
        Cacheable.cache[key] = { content: c } if c.present?
        c
      end
    end
  end
end
