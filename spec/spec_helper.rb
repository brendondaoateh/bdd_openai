# frozen_string_literal: true

require 'test_coverage_setup'

require 'bdd_openai'
require 'dotenv/load'
require 'vcr'
require 'simplecov'

SimpleCov.start

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.preserve_exact_body_bytes { true }
  config.define_cassette_placeholder('<OPENAI_API_KEY>') { ENV['OPENAI_API_KEY'] }
end
