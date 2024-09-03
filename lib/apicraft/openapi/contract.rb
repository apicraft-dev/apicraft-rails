# frozen_string_literal: true

module Apicraft
  module Openapi
    # A single openapi yaml file is represented
    # by this Contract class.
    class Contract
      include Concerns::Cacheable
      @store = []

      attr_accessor :document

      def initialize(document)
        @document = document
      end

      def operation(method, path)
        with_cache("operation-#{method.downcase}-#{path}") do
          op = document.request_operation(method.downcase, path)
          Operation.new(op) if op.present?
        end
      end

      class << self
        def create!(document)
          c = new(document)
          @store << c
          c
        end

        def all
          @store
        end

        def find_by_operation(method, path)
          found = nil

          all.each do |c|
            if c.operation(method, path).present?
              found = c
              break
            end
          end

          found
        end
      end
    end
  end
end
