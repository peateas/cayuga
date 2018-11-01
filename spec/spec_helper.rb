require 'bundler/setup'
require 'cayuga'
require 'factory_information_helper'
require 'tool_information_helper'


RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include FactoryInformationHelper
  # noinspection RubyResolve
  config.include ToolInformationHelper, for_tools: true

end

