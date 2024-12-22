# frozen_string_literal: true

namespace :apicraft do
  desc "Initialize apicraft"
  task init: :environment do
    destination = Rails.root.join('config', 'initializers', 'apicraft.rb')
    if File.exist?(destination)
      puts "File already exists: #{destination}"
    else
      template = File.expand_path('../templates/initializer.rb', __dir__)
      FileUtils.cp(template, destination)
      puts "Apicraft initializer created at config/initializers/apicraft.rb"
    end
  end
end
