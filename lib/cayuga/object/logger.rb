#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'cayuga'

module Cayuga
  module Object

    # Cayuga Object Logger
    # noinspection RubyModuleAsSuperclassInspection
    class Logger < Singleton

      def generic_log_file(name)
        filename = name.stringify.filenamify('.log')
        "#{factory.logs_directory}/#{filename}"
      end

      def log_names
        @logs.keys.freeze
      end

      def log_filename(name)
        @logs[name.symbolize]
      end

      alias [] log_filename

      def log_appender_name(name)
        name.stringify + annotation
      end

      def log_appender(name)
        all = SemanticLogger.appenders.select do |log|
          log.name == log_appender_name(name)
        end
        count = all.count
        raise "More than one log with name #{name}" if count > 1
        count == 1 ? all[0] : nil
      end

      def log_log?(name)
        !@logs[name.symbolize].nil?
      end

      def log_log!(name, filename: nil, stream: nil, filter: nil, level: :info)
        unless log_log?(name)
          remove_any_orphan_appender(name)
          make_appender(name, filename, stream, filter, level)
        end
        logger.info('log created', payload: { name: name })
        logger.debug('logs', payload: { log_names: log_names })
        logger.debug('logs', payload: { count: SemanticLogger.appenders.count })
        log_filename(name)
      end

      private_class_method :new

      private

      attr_reader :annotation

      def initialize(factory, configuration)
        @factory = factory
        @configuration = configuration
        @configuration_name = factory.configuration_name
        @annotation = fetch_annotation
        @logs = {}
        create_logs
      end

      def fetch_annotation
        value = configuration[:constants][:log_annotation_marker]
        value.nil? ? '' : value
      end

      def create_logs
        log_log!(:console, stream: $stderr, level: :warn)
        log_log!(:main, filename: generic_log_file(:main))
        log_log!(factory.class, filter: Regexp.new(factory.class.stringify))
        log_log!(self.class, filter: Regexp.new(self.class.stringify))
      end

      def log_appender_exists?(name)
        !log_appender(name.symbolize).nil?
      end

      def make_appender(name, filename, stream, filter, level)
        if stream.nil?
          if filename.nil?
            filename = factory.logs_directory + '/' + name.classify.log_file
          end
          log = SemanticLogger.add_appender(file_name: filename, filter: filter)
        else
          log = SemanticLogger.add_appender(io: stream, filter: filter)
        end
        log.name = log_appender_name(name)
        log.level = level
        @logs[name.symbolize] = filename || stream || name.stringify
        log
      end

      def remove_any_orphan_appender(name)
        return if log_log?(name)
        return unless log_appender_exists?(name)
        logger.warn('log without registration', payload: { name: name })
        logger.debug('log without registration', payload: { log: log_names })
        SemanticLogger.remove_appender(log_appender(name))
      end

    end
  end
end
