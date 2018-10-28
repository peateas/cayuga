#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'cayuga/object/logger'
require 'logging_test_class'

RSpec.describe Cayuga::Object::Logger do
  specify 'a class should have loggers' do
    expect(LoggingTestClass).to be_instance_of Class
    expect(LoggingTestClass).to respond_to 'logger'
    instance = LoggingTestClass.new
    expect(instance).to respond_to 'logger'
    expect(LoggingTestClass).to respond_to 'log'
    expect(instance).to respond_to 'log'
  end

  specify 'a class should log information at different levels' do
    instance = LoggingTestClass.new
    instance.make_logs
    log = SemanticLogger.appenders.detect { |a| a.name == 'development-log' }
    sleep(1)
    name = 'logs/development.log'
    logs = File.new(name).readlines
    puts("LOGS")
    puts(logs)
    puts('***************************')
    raise('not yet finished')
  end


  it 'should have classes with their own log file'
  it 'should have classes that you can change the log level in a file'
  it 'should have classes that you log information at different levels'
  it 'should have classes that can log to the console and to the main log file'
  it 'should be able to change the log level of the console and the main log file in a file'

end