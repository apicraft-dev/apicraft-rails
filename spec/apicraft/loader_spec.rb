# frozen_string_literal: true

require "spec_helper"

RSpec.describe Apicraft::Loader do
  let(:contracts_path) { "#{Bundler.root}/spec/fixtures/contracts" }

  before do
    Apicraft.configure do |c|
      c.contracts_path = contracts_path
      c.strict_reference_validation = true
    end
  end

  describe ".load!" do
    context "when the contracts directory exists" do
      before do
        described_class.load!
      end

      it "loads and processes files into contract objects" do
        expect(
          Apicraft::Openapi::Contract.all.count
        ).to eq(2)
      end

      it "sets up the routes" do
        expect(
          Apicraft::Web::Router.routes.keys
        ).to include("/books.json", "/books.yaml")
      end
    end

    context "when the contracts directory does not exist" do
      before do
        allow(Dir).to receive(:exist?).with(contracts_path).and_return(false)
      end

      it "raises an error" do
        expect { described_class.load! }.to raise_error(
          Apicraft::Errors::InvalidContractsPath
        )
      end
    end
  end
end
