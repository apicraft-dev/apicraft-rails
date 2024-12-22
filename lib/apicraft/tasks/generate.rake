# frozen_string_literal: true

namespace :apicraft do
  desc "Generate an example spec file"

  task generate: :environment do |_t, _args|
    arguments = ARGV.reduce({}) do |final, current|
      key, val = current.split("=").map(&:strip)
      final.merge!({
                     key => val
                   })
    end

    filepath = arguments["file"]
    template = File.expand_path("../templates/openapi.example.yaml", __dir__)

    # root path of all contracts
    contracts_path = Apicraft.config.contracts_path

    # Split the filepath into parts to extract the directory structure and file name
    path_parts = filepath.split("/")
    dir_path = File.join(contracts_path, *path_parts[0..-2])
    file_name = "#{path_parts[-1]}.yaml"

    # Create the directory if it doesn't exist
    FileUtils.mkdir_p(dir_path) unless Dir.exist?(dir_path)

    File.write(File.join(dir_path, file_name), File.read(template))
  end
end
