# frozen_string_literal: true

module Apicraft
  # Recursively loads and processes YAML files from the
  # application's contract folder during the application boot.
  # This class is responsible for loading and initializing the
  # contracts defined in the YAML files.
  class Loader
    def self.load!
      contracts_path = Apicraft.config.contracts_path
      return unless Dir.exist?(contracts_path)

      Find.find(contracts_path) do |path|
        next unless File.file?(path) && %w[.yaml .yml].include?(File.extname(path))

        load_file!(path)

        route = path.sub(contracts_path.to_s, '')
        Web::Router.add(route, path)
      end
    end

    def self.load_file!(file)
      Openapi::Contract.create!(
        OpenAPIParser.parse(
          YAML.load_file(file)
        )
      )
    end
  end
end
