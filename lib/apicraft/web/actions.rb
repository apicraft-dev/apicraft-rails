# frozen_string_literal: true

module Apicraft
  module Web
    # Web actions to be handled from
    # the rack app.
    module Actions
      def self.index(view_path)
        [
          File.read(view_path),
          "text/html"
        ]
      end

      def self.swaggerdoc(view_path)
        @vars = {
          urls: Router.contract_urls
        }

        [
          ERB.new(
            File.read(view_path)
          ).result(binding),
          "text/html"
        ]
      end

      def self.redoc(view_path)
        @vars = {
          urls: Router.contract_urls
        }

        [
          ERB.new(
            File.read(view_path)
          ).result(binding),
          "text/html"
        ]
      end

      def self.contract(view_path)
        [
          File.read(view_path),
          MIME::Types.type_for(view_path)[0].to_s
        ]
      end

      def self.introspect(method, view_path)
        [
          Apicraft::Openapi::Contract.find_by_operation(
            method, view_path
          )&.operation(
            method, view_path
          )&.raw_schema&.to_json,
          "application/json"
        ]
      end
    end
  end
end
