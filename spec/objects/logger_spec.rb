#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'test/test2018/logging_test'

RSpec.describe Cayuga::Object::Logger do
  subject do
    factory[Cayuga::Object::Logger]
  end
  let(:target) { Test2018::LoggingTest }
  let(:logs) { [:main, :console] }

  it 'should exist' do
    expect(subject).to be_instance_of Cayuga::Object::Logger
  end

  it 'should have loggers' do
    expect(subject.class).to respond_to 'logger'
    expect(subject).to respond_to 'logger'
    expect(subject.class).to respond_to 'log'
    expect(subject).to respond_to 'log'
  end

  it 'should have primary logs' do
    # noinspection RubyResolve
    expect(subject.logs).to include(*logs)
  end

  it 'should have its own log' do
    # noinspection RubyResolve
    expect(subject.logs).to include subject.class.symbolize
  end

  it 'should have a file for its log' do
    expect(subject.log_file).not_to be(nil), "no log file for #{subject.class.stringify}"
  end

  it 'should be able to access logs' do
    verify_log_log(target)

    [:console, :main, subject.class, target].each do |name|
      log = subject[name]
      expect(log).not_to be_nil, "no log for #{name}"
      expect(log).to be_a(String) | be_a(IO)
    end
  end

  it 'should be able to get tail of log' do
    verify_log_log(target)
    instance = target.new
    instance.make_logs
    SemanticLogger.flush
    records = subject.tail(target)
    expect(records.size).to be > 0
  end

  it 'should have logs in the configured directory' do
    directory = factory.logs_directory
    file = [directory, subject.class.filenamify(:log)].join('/')
    expect(subject[subject.class]).to be == file
    records = nil
    thread = Thread.new do
      thread_info = "#{Process.pid}:#{Thread.current.name}"
      filter = Regexp.new(thread_info)
      subject.log.info(
        'testing log directory',
        payload = { expected: file, actual: subject[subject.class] }
      )
      SemanticLogger.flush
      File.open(file) do |log|
        log.extend File::Tail
        log.return_if_eof = true
        records = log.backward(5).tail(5).select { |record| record =~ filter }
      end
    end
    thread.join
    expect(records.size).to be == 1
  end

  specify 'a loggable class should have loggers' do
    expect(target).to be_instance_of Class
    expect(target).to respond_to 'logger'
    instance = target.new
    expect(instance).to respond_to 'logger'
    expect(target).to respond_to 'log'
    expect(instance).to respond_to 'log'
  end

  specify 'a loggable class should have its own log file' do
    # noinspection RubyResolve
    expect(subject.logs).to include target.symbolize
  end

  specify 'a loggable class should be able to change log levels' do
    expect { target.log.level = :info; target.log.level = :debug }.to change(target.log, :level)
  end

  specify 'a loggable class should log information at different levels' do
    instance = target.new
    check_logs(:info, 1) { instance.make_logs }
    check_logs(:debug, 2) { instance.make_logs }
  end

  specify 'a loggable class log should only log messages from its logger' do
    thread = Thread.new do
      thread_info = "#{Process.pid}:#{Thread.current.name}"
      filter = Regexp.new(thread_info)
      instance = target.new
      instance.log.level = :trace
      instance.make_logs
      subject.log.level = :trace
      subject.log.trace("testing class logger")
      SemanticLogger.flush
      records = subject.tail(target).select { |record| record =~ filter }
      expect(records.size).to be == 2
    end
    thread.join
  end

  def verify_log_log(name)
    subject.log_log!(
      name,
      filename: subject.generic_log_file(name),
      filter: Regexp.new(name.stringify)
    ) unless subject.log_log?(name)
  end

  def check_logs(level, count, &block)
    target.log.level = level
    logs = get_logs &block
    expect(logs.size).to be == count
  end

  def get_logs
    records = nil
    thread = Thread.new do
      thread_info = "#{Process.pid}:#{Thread.current.name}"
      filter = Regexp.new(thread_info)
      yield
      SemanticLogger.flush
      records = subject.tail(target).select { |record| record =~ filter }
    end
    thread.join
    records
  end

end
