# frozen_string_literal: true

require "spec_helper"

RSpec.describe Apicraft::Config do
  let(:default_headers) do
    {
      response_code: "Apicraft-Response-Code",
      introspect: "Apicraft-Introspect",
      mock: "Apicraft-Mock",
      delay: "Apicraft-Delay",
      content_type: "Content-Type"
    }.with_indifferent_access
  end

  let(:default_opts) do
    {
      contracts_path: nil,
      headers: default_headers,
      mocks: true,
      introspection: true,
      strict_reference_validation: true,
      request_validations: true,
      max_allowed_delay: 30
    }.with_indifferent_access
  end

  let(:config) { described_class.new }

  describe "#initialize" do
    context "when no options are passed" do
      it "uses default headers" do
        expect(config.headers).to eq(default_headers)
      end

      it "initializes with mocks enabled" do
        expect(config.mocks).to be_truthy
      end

      it "initializes with introspection enabled" do
        expect(config.introspection).to be_truthy
      end

      it "initializes with strict reference validation enabled" do
        expect(config.strict_reference_validation).to be_truthy
      end

      it "initializes with nil contracts_path" do
        expect(config.contracts_path).to be_nil
      end

      it "initializes with default max allowed delay" do
        expect(config.max_allowed_delay).to eq(30)
      end
    end

    context "when custom options are passed" do
      let(:custom_opts) do
        {
          contracts_path: "/custom/path",
          mocks: false,
          introspection: false,
          strict_reference_validation: false,
          max_allowed_delay: 15
        }
      end
      let(:config) { described_class.new(custom_opts) }

      it "sets custom contracts_path" do
        expect(config.contracts_path).to eq("/custom/path")
      end

      it "disables mocks" do
        expect(config.mocks).to be_falsey
      end

      it "disables introspection" do
        expect(config.introspection).to be_falsey
      end

      it "disables strict_reference_validation" do
        expect(config.strict_reference_validation).to be_falsey
      end

      it "sets custom max_allowed_delay" do
        expect(config.max_allowed_delay).to eq(15)
      end
    end
  end

  describe "#headers" do
    let(:config) { described_class.new }

    it "returns the default headers" do
      expect(config.headers).to eq(default_headers)
    end

    it "merges with custom headers when set" do
      custom_headers = { custom_header: "Custom-Header" }
      config.headers = custom_headers
      expect(config.headers).to include(
        custom_headers.with_indifferent_access
      )
    end
  end
end
