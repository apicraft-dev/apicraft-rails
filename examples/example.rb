# frozen_string_literal: true

require "pry"

Apicraft::Loader.load_file!(
  File.open("#{Bundler.root}/examples/example2.yaml")
)

contract = Apicraft::Openapi::Contract.find_by_operation(
  "DELETE",
  "/pets/1"
)

operation = contract.operation("delete", "/pets/1")
response = operation.response_for(204)
response.mock("application/json")
