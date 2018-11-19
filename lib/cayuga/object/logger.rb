#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'file-tail'
require 'cayuga'

module Cayuga
  module Object
    class Logger < Singleton

      def generic_log_file(name)
        "#{factory.logs_directory}/#{name.stringify.filenamify('.log')}"
      end

      def log_names
        @logs.keys.freeze
      end

      def log_filename(name)
        @logs[name.symbolize]
      end

      alias [] log_filename

      def log_appender(name)
        all = SemanticLogger.appenders.select { |log| log.name == name.stringify }
        count = all.count
        raise RuntimeError, "More than one log with name #{name}" if count > 1
        if count == 1
          all[0]
        else
          nil
        end
      end

      def log_log?(name)
        not @logs[name.symbolize].nil?
      end

      def log_log!(name, filename: nil, stream: nil, filter: nil, level: :info)
        symbol = name.symbolize
        return log_filename(symbol) if log_log?(symbol)
        if log_appender_exists?(symbol)
          logger.warn('no entry for log', payload = { name: symbol })
          logger.warn('no entry for log', payload = { log: log_names })
          @logs[symbol] = filename || stream
          if log_filename(symbol).nil?
            @logs[symbol] = factory.logs_directory + '/' + name.classify.log_file
          end
          return
        end
        if filename.nil?
          if stream.nil?
            #must be a class
            filename = factory.logs_directory + '/' + name.classify.log_file
            log = SemanticLogger.add_appender(file_name: filename, filter: filter)
          else
            log = SemanticLogger.add_appender(io: stream, filter: filter)
          end
        else
          log = SemanticLogger.add_appender(file_name: filename, filter: filter)
        end
        log.name = name.stringify
        log.level = level
        @logs[name.symbolize] = filename || stream || name.stringify
        logger.info('logs', payload = { log_names: log_names })
        logger.info('logs', payload = { count: SemanticLogger.appenders.count })
      end

      private_class_method :new

      private

      attr_reader :factory

      def initialize(factory, configuration)
        @factory = factory
        @logs = {}
        log_log!(:console, stream: $stderr, level: :warn)
        log_log!(:main, filename: generic_log_file(:main))
        log_log!(factory.class, filter: Regexp.new(factory.class.stringify))
        log_log!(self.class, filter: Regexp.new(self.class.stringify))
      end

      def log_appender_exists?(name)
        name = name.symbolize
        log = log_appender(name)
        if log.nil?
          false
        else
          true
        end
      end

    end
  end
end
