# frozen_string_literal: true

require "spec_helper"

RSpec.describe Apicraft::Openapi::Response do
  let(:contracts_path) { "#{Bundler.root}/spec/fixtures/contracts" }
  let(:contract) { Apicraft::Openapi::Contract.all[0] }
  let(:operation) { contract.operation("GET", "/books/1") }
  let(:response_ok) { operation.response_for("200") }

  before do
    Apicraft.configure do |c|
      c.contracts_path = contracts_path
      c.strict_reference_validation = true
    end
    Apicraft::Loader.load!
  end

  describe "#description" do
    it "returns description of the response" do
      expect(response_ok.description).to eq("A single book")
    end
  end

  describe "#default_content_type" do
    it "returns first content type of the response" do
      expect(response_ok.default_content_type).to eq("application/json")
    end
  end
end
