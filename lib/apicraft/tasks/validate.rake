# frozen_string_literal: true

namespace :apicraft do
  desc "Validate all contracts"
  task validate: :environment do
    Apicraft::Validator.validate!
  end
end
