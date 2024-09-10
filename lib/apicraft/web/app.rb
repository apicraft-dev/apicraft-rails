# frozen_string_literal: true

module Apicraft
  module Web
    # Apicraft Rack App that is mounted
    # for all the views to be served
    class App
      def self.call(env)
        return unauthorized_response unless authorized?(env)

        uri = env["REQUEST_URI"]
        method = env["REQUEST_METHOD"]
        Router.namespace = env["SCRIPT_NAME"]
        path = uri.split(
          Router.namespace
        )[-1] || "/"

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

      def self.authorized?(env)
        auth = Rack::Auth::Basic::Request.new(env)
        username, password = auth.provided? && auth.basic? && auth.credentials
        @use&.call(username, password).present?
      end

      def self.use(&block)
        @use = block
      end

      def self.unauthorized_response
        [
          401,
          {
            "Content-Type": "text/plain",
            "WWW-Authenticate": "Basic realm=\"Restricted Area\""
          },
          ["Unauthorized"]
        ]
      end
    end
  end
end
