# frozen_string_literal: true

module Apicraft
  module Web
    # Managing routes and view paths
    module Router
      WEB_ROOT = File.expand_path(
        "#{File.dirname(__FILE__)}/../../../web"
      )
      IMAGES_DIR = "#{WEB_ROOT}/assets/images"

      def self.routes
        @routes ||= {
          "/": {
            action: :render_erb,
            view_path: "#{WEB_ROOT}/views/index.erb"
          },
          "/swaggerdoc": {
            action: :render_erb,
            view_path: "#{WEB_ROOT}/views/swaggerdoc.erb"
          },
          "/redoc": {
            action: :render_erb,
            view_path: "#{WEB_ROOT}/views/redoc.erb"
          },
          "/rapidoc": {
            action: :render_erb,
            view_path: "#{WEB_ROOT}/views/rapidoc.erb"
          },
          "/assets/images/thumb.png": {
            action: :images,
            view_path: "#{IMAGES_DIR}/apicraft_thumb.png"
          },
          "/assets/images/logo.png": {
            action: :images,
            view_path: "#{IMAGES_DIR}/apicraft.png"
          }
        }.with_indifferent_access
      end

      def self.add(path, view_path)
        routes[path] = {
          action: :contract,
          view_path: view_path
        }
      end

      def self.load_response!(_method, path)
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
