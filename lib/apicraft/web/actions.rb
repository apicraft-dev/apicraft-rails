# frozen_string_literal: true

module Apicraft
  module Web
    # Web actions to be handled from
    # the rack app.
    module Actions
      def self.render_erb(view_path)
        @vars = {
          urls: Router.contract_urls,
          namespace: Router.namespace,
          version: Apicraft::VERSION
        }

        [
          ERB.new(
            File.read(view_path)
          ).result(binding),
          "text/html"
        ]
      end

      def self.images(view_path)
        [
          File.read(view_path),
          mime_type(view_path)
        ]
      end

      def self.contract(view_path)
        [
          File.read(view_path),
          MIME::Types.type_for(view_path)[0].to_s
        ]
      end

      def self.mime_type(view_path)
        ext = File.extname(view_path)
        Rack::Mime.mime_type(ext)
      end
    end
  end
end
