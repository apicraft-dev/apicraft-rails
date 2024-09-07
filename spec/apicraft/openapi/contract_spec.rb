# frozen_string_literal: true

require "spec_helper"

RSpec.describe Apicraft::Openapi::Contract do
  let(:contracts_path) { "#{Bundler.root}/spec/fixtures/contracts" }

  before do
    Apicraft.configure do |c|
      c.contracts_path = contracts_path
      c.strict_reference_validation = true
    end
    Apicraft::Loader.load!
  end

  let(:contract) { described_class.all[0] }

  describe "#operation" do
    context "when found" do
      it "returns an operation instance" do
        op = contract.operation("GET", "/books")

        expect(op).to be_a(Apicraft::Openapi::Operation)
        expect(op.summary).to eq("Get a list of books")
      end
    end

    context "when not found" do
      it "returns nil" do
        op = contract.operation("GET", "/v2/books")
        expect(op).to be_blank
      end
    end
  end

  describe ".find_by_operation" do
    context "when found" do
      it "returns an contract instance" do
        c = described_class.find_by_operation("GET", "/books")

        expect(c).to be_a(Apicraft::Openapi::Contract)
      end
    end

    context "when not found" do
      it "returns nil" do
        c = described_class.find_by_operation("GET", "/v2/books")
        expect(c).to be_blank
      end
    end
  end
end