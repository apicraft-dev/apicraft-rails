# frozen_string_literal: true

module Apicraft
  module Web
    # Apicraft Rack App that is mounted
    # for all the views to be served
    class App
      def self.call(env)
        uri = env["REQUEST_URI"]
        method = env["REQUEST_METHOD"]
        Router.namespace = env["SCRIPT_NAME"]
        path = uri.split(
          Router.namespace
        )[-1]

        content, content_type = Router.load_response!(
          method, path
        )

        raise Errors::RouteNotFound if content.nil?

        [
          200,
          { 'Content-Type': content_type },
          [content]
        ]
      rescue Errors::RouteNotFound
        [
          404,
          { 'Content-Type': "text/plain" },
          ["Error: not found"]
        ]
      rescue StandardError => e
        [
          500,
          { 'Content-Type': "text/plain" },
          ["Error: #{e.message}"]
        ]
      end
    end
  end
end
