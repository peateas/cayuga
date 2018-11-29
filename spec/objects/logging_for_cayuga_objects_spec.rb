#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
RSpec.describe 'cayuga object' do
  subject do
    [
      factory,
      factory[Cayuga::Object::Constants],
      factory[Cayuga::Object::Logger],
      factory[Test2018::Singleton],
      factory[Test2018::NamedObject, :one]
    ]
  end
  let(:logger) { factory[Cayuga::Object::Logger] }

  it 'should have its own log file' do
    subject.each do |target|
      # noinspection RubyResolve
      expect(logger.log_names).to include target.class.symbolize
    end
  end

  it 'should only log messages from themselves in its own logs' do
    subject.each do |instance|
      thread = Thread.new do
        thread_info = "#{Process.pid}:#{Thread.current.name}"
        filter = Regexp.new(thread_info)
        instance.log.info('testing object log exclusivity')
        logger.log.info('extra log for exclusivity test')
        factory.log.info('extra log for exclusivity test')
        SemanticLogger.flush
        records = tail(logger, instance.class).select do |record|
          record =~ filter
        end
        case instance
          when Cayuga::Object::Factory, Cayuga::Object::Logger
            expect(records.size).to be == 2
          else
            expect(records.size).to be == 1
        end
      end
      thread.join
    end
  end

  it 'should log when they get created and released' do
    logger[:main]
    objects = subject - [factory, logger]
    objects.each do |_target|
    end
    pending 'more work to do'
    raise 'finish implementing'
  end

end
