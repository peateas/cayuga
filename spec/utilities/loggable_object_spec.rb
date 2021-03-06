# frozen_string_literal: true

#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'test/test2019/logging_test'

RSpec.describe 'loggable objects' do
  subject { Test2019::LoggingTest }
  let(:logger) { factory[Cayuga::Object::Logger] }
  it 'should have loggers' do
    expect(subject).to be_instance_of Class
    expect(subject).to respond_to 'logger'
    instance = subject.new
    expect(instance).to respond_to 'logger'
    expect(subject).to respond_to 'log'
    expect(instance).to respond_to 'log'
  end

  it 'should be able to change log levels' do
    verify_log_log(factory, subject)
    [subject.log, logger.log_appender(subject)].each do |entity|
      entity.level = :info
      expect { entity.level = :debug }.to change(entity, :level)
    end
  end

  it 'should log information at different levels' do
    verify_log_log(factory, subject)
    instance = subject.new
    check_logs(factory, subject, :info, 1) { instance.make_logs }
    check_logs(factory, subject, :debug, 2) { instance.make_logs }
  end

end
