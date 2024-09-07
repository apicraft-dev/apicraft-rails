# frozen_string_literal: true

require "spec_helper"

RSpec.describe Apicraft::Openapi::Response do
  let(:contracts_path) { "#{Bundler.root}/spec/fixtures/contracts" }

  before do
    Apicraft.configure do |c|
      c.contracts_path = contracts_path
      c.strict_reference_validation = true
    end
    Apicraft::Loader.load!
  end

  let(:contract) { Apicraft::Openapi::Contract.all[0] }
  let(:operation) { contract.operation("GET", "/books/1") }
  let(:response200) { operation.response_for("200") }
  let(:response404) { operation.response_for("404") }

  describe "#description" do
    it "returns description of the response" do
      expect(response200.description).to eq("A single book")
      expect(response404.description).to eq("Book not found")
    end
  end

  describe "#default_content_type" do
    it "returns first content type of the response" do
      expect(response200.default_content_type).to eq("application/json")
      expect(response404.default_content_type).to be_blank
    end
  end
end
