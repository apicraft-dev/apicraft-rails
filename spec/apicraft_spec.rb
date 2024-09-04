# frozen_string_literal: true

require "spec_helper"

RSpec.describe Apicraft do
  it "has a version number" do
    expect(Apicraft::VERSION).not_to be_nil
  end

  describe ".configure" do
    it "yields the shared config object" do
      expect { |b| described_class.configure(&b) }.to(
        yield_with_args(described_class.config)
      )
    end

    context "when configuring via a block" do
      before do
        described_class.configure do |config|
          config.contracts_path = "/test"
          config.mocks = false
          config.strict_reference_validation = false
        end
      end

      it "sets the contracts_path configuration" do
        expect(
          described_class.config.contracts_path
        ).to eq("/test")
      end

      it "sets the mocks configuration" do
        expect(
          described_class.config.mocks
        ).to be(false)
      end

      it "sets the strict_reference_validation configuration" do
        expect(
          described_class.config.strict_reference_validation
        ).to be(false)
      end
    end
  end
end
