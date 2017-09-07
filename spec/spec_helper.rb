require "bundler/setup"
require "webmock/rspec"
require "otc"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def load_response(response)
  File.read(File.expand_path("../fixtures/responses/#{response}_response.json", __FILE__))
end
