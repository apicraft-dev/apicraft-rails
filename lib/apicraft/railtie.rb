# frozen_string_literal: true

module Apicraft
  # Hooks into the application boot process
  # using Rails::Railtie
  class Railtie < Rails::Railtie
    initializer "apicraft.use_middlewares" do
      [
        Apicraft::Middlewares::Mocker,
        Apicraft::Middlewares::Introspector,
        Apicraft::Middlewares::RequestValidator
      ].each { |mw| Rails.application.config.middleware.use mw }
    end

    config.after_initialize do
      Apicraft::Loader.load!
    end

    rake_tasks do
      load "apicraft/tasks/validate.rake"
      load "apicraft/tasks/init.rake"
      load "apicraft/tasks/generate.rake"
    end
  end
end
