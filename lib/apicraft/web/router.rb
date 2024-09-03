# frozen_string_literal: true

module Apicraft
  module Web
    # Managing routes and view paths
    module Router
      WEB_ROOT = File.expand_path(
        "#{File.dirname(__FILE__)}/../../../web"
      )

      def self.routes
        @routes ||= {
          "/": {
            action: :index,
            view_path: "#{WEB_ROOT}/views/index.html"
          },
          "/swaggerdoc": {
            action: :swaggerdoc,
            view_path: "#{WEB_ROOT}/views/swaggerdoc.erb"
          },
          "/redoc": {
            action: :redoc,
            view_path: "#{WEB_ROOT}/views/redoc.erb"
          }
        }.with_indifferent_access
      end

      def self.add(path, view_path)
        routes[path] = {
          action: :contract,
          view_path: view_path
        }
      end

      def self.load_response!(method, path)
        return Actions.introspect(method, path) unless routes[path].present?

        Actions.send(
          routes[path][:action],
          routes[path][:view_path]
        )
      end

      def self.namespace=(namespace)
        @namespace = namespace
      end

      def self.namespace
        @namespace
      end

      def self.contract_urls
        contract_keys = routes.select do |_k, v|
          v[:action] == :contract
        end.keys
        contract_keys.map do |k|
          "#{Router.namespace}#{k}"
        end
      end
    end
  end
end
