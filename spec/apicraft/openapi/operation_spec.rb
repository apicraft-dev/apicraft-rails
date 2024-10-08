# frozen_string_literal: true

require "spec_helper"

RSpec.describe Apicraft::Openapi::Operation do
  let(:contracts_path) { "#{Bundler.root}/spec/fixtures/contracts" }
  let(:contract) { Apicraft::Openapi::Contract.all[0] }
  let(:operation) { contract.operation("GET", "/books/1") }

  before do
    Apicraft.configure do |c|
      c.contracts_path = contracts_path
      c.strict_reference_validation = true
    end
    Apicraft::Loader.load!
  end

  describe "#responses" do
    it "returns all responses of the operation" do
      responses = operation.responses
      expect(responses.response.keys).to eq(%w[200 404])
    end
  end

  describe "#summary" do
    it "returns summary of the operation" do
      expect(operation.summary).to eq("Get a specific book by ID")
    end
  end

  describe "#response_for" do
    context "when 200" do
      it "returns the 200 response" do
        expect(operation.response_for("200")).to be_a(
          Apicraft::Openapi::Response
        )
      end
    end

    context "when 404" do
      it "returns the 404 response" do
        expect(operation.response_for("404")).to be_a(
          Apicraft::Openapi::Response
        )
      end
    end

    context "when not found" do
      it "returns nil" do
        expect(operation.response_for("2001")).to be_blank
      end
    end
  end
end
