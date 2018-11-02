#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#

module LoggerInformationHelper
  def verify_log_log(name)
    logger.log_log!(
      name,
      filename: logger.generic_log_file(name),
      filter: Regexp.new(name.stringify)
    ) unless logger.log_log?(name)
  end

  def check_logs(target, level, count, &block)
    target.log.level = level
    logger.log_appender(target).level = nil
    logs = get_logs(subject, &block)
    expect(logs.size).to be == count, "expected #{count} logs for #{target}, got #{logs.size}"
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