# frozen_string_literal: true

require "spec_helper"

RSpec.describe Apicraft do
  it "has a version number" do
    expect(Apicraft::VERSION).not_to be_nil
  end

  describe '.configure' do
    it 'yields the shared config object' do
      expect { |b| Apicraft.configure(&b) }.to yield_with_args(Apicraft.config)
    end

    it 'allows configuration via a block' do
      Apicraft.configure do |config|
        config.dir = '/test'
        config.mocks = false
        config.strict_reference_validation = false
      end

      c = Apicraft.config
      expect(c.dir).to eq('/test')
      expect(c.mocks).to eq(false)
      expect(c.strict_reference_validation).to eq(false)
    end
  end
end
