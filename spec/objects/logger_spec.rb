#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'test/test2018/logging_test'

RSpec.describe Cayuga::Object::Logger do
  subject { factory[Cayuga::Object::Logger] }
  let(:logs) do
    %I[main console #{factory.class.symbolize} #{subject.class.symbolize}]
  end

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
    expect(subject.log_names).to include(*logs)
  end

  it 'should have a file for its log' do
    expect(subject.class.log_file).not_to be(nil),
      "no log file for #{subject.class.stringify}"
  end

  it 'should be able to access logs' do
    logs.each do |name|
      log = subject[name]
      expect(log).not_to be_nil, "no log for #{name}"
      expect(log).to be_a(String) | be_an(IO)
    end
  end

  it 'should be able to get tail of log' do
    subject.log.info('testing tail')
    SemanticLogger.flush
    records = tail(subject, :main)
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
        payload: { expected: file, actual: subject[subject.class] }
      )
      SemanticLogger.flush
      File.open(file) do |log|
        log.extend File::Tail
        log.return_if_eof = true
        records = log.backward(5).tail(5).select { |record| record =~ filter }
      end
    end
    thread.join
    expect(records).not_to be_nil
    # noinspection RubyNilAnalysis
    expect(records.size).to be == 1
  end

end
