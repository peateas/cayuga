#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'file-tail'

module LoggerInformationHelper
  def verify_log_log(a_factory, name)
    return if a_factory.logger.log_log?(name)

    filter =
      case name
        when Class
          name.name
        else
          name.stringify
      end
    a_factory.logger.log_log!(
      name,
      filename: a_factory.logger.generic_log_file(name),
      filter: Regexp.new(filter)
    )
  end

  def check_logs(a_factory, target, level, count, &block)
    target.log.level = level
    a_factory.logger.log_appender(target).level = nil
    logs = get_logs(a_factory.logger.log_filename(target), &block)
    expect(logs.size).to be == count,
      "expected #{count} logs for #{target}, got #{logs.size}"
  end

  def get_logs(name, count: 5)
    records = nil
    thread = Thread.new do
      thread_info = "#{Process.pid}:#{Thread.current.name}"
      filter = Regexp.new(thread_info)
      yield
      SemanticLogger.flush
      records = tail(name, count: count).select { |record| record =~ filter }
    end
    thread.join
    records
  end

  def tail(name, count: 5)
    File.open(name) do |log|
      log.extend File::Tail
      log.return_if_eof = true
      log.backward(count).tail(count)
    end
  end

end
