# frozen_string_literal: true

module Apicraft
  # All constants for Apicraft
  module Constants
    HTTP_METHODS = %i[
      get
      post
      put
      patch
      delete
      head
      options
      trace
    ].freeze

    MIME_TYPE_CONVERTORS = {
      "application/json": :to_json,
      "application/xml": :to_xml,
      "application/yaml": :to_yaml,
      "application/x-yaml": :to_yaml,
      "text/csv": :to_csv,
      "text/plain": :to_s,
      "text/html": :to_html,
      "application/msgpack": :to_msgpack
    }.with_indifferent_access
  end
end
