require 'bundler/setup'
require 'cayuga'
require 'factory_information_helper'
require 'logger_information_helper'
require 'tool_information_helper'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    CONFIGURATION_INFORMATION = 'spec/test/configuration/cayuga_test_config.json'.freeze
    FACTORY =  Cayuga::Object::Factory.new CONFIGURATION_INFORMATION
  end

  config.include FactoryInformationHelper
  config.include LoggerInformationHelper
  # noinspection RubyResolve
  config.include ToolInformationHelper, for_tools: true

end

