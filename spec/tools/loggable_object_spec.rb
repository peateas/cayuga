#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'test/test2018/logging_test'

RSpec.describe 'loggable objects'  do
  subject { Test2018::LoggingTest }
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
    expect { subject.log.level = :info; subject.log.level = :debug }.to change(subject.log, :level)
  end

  it 'should log information at different levels' do
    verify_log_log(subject)
    instance = subject.new
    check_logs(subject,:info, 1) { instance.make_logs }
    check_logs(subject,:debug, 2) { instance.make_logs }
  end

  def verify_log_log(name)
    logger.log_log!(
      name,
      filename: logger.generic_log_file(name),
      filter: Regexp.new(name.stringify)
    ) unless logger.log_log?(name)
  end

  def check_logs(target, level, count, &block)
    target.log.level = level
    logs = get_logs(subject, &block)
    expect(logs.size).to be == count
  end

  def get_logs(target)
    records = nil
    thread = Thread.new do
      thread_info = "#{Process.pid}:#{Thread.current.name}"
      filter = Regexp.new(thread_info)
      yield
      SemanticLogger.flush
      records = logger.tail(target).select { |record| record =~ filter }
    end
    thread.join
    records
  end

end
