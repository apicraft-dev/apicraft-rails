# frozen_string_literal: true

module Apicraft
  # Hooks into the application boot process
  # using Rails::Railtie
  class Railtie < Rails::Railtie
    initializer "apicraft.load_api_contracts" do
      Apicraft::Loader.load!
    end

    rake_tasks do
      load "apicraft/tasks/validate.rake"
    end
  end
end
