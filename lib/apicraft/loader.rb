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
        next unless File.file?(path) && %w[.yaml .yml .json].include?(File.extname(path))

        load_file!(path)

        route = path.sub(contracts_path.to_s, "")
        Web::Router.add(route, path)
      end
    end

    def self.config
      Apicraft.config
    end

    def self.load_file!(file)
      ext = File.extname(file)

      parsed = if ext == ".json"
                 JSON.parse(File.read(file))
               else
                 YAML.load_file(file)
               end

      OpenAPIParser.parse(
        parsed,
        {
          strict_reference_validation: config.strict_reference_validation
        }
      )

      Openapi::Contract.create!(
        OpenAPIParser.parse(parsed)
      )
    end
  end
end
