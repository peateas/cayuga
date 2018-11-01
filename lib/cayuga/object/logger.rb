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

      def logs
        @logs.keys.freeze
      end

      def log_log(name)
        @logs[name.symbolize]
      end

      alias [] log_log

      def log_log?(name)
        not @logs[name.symbolize].nil?
      end

      def log_log!(name, filename: nil, stream: nil, filter: nil)
        return log_log(name) if log_log?(name)
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
        @logs[name.symbolize] = filename || stream || name.stringify
      end

      def tail(name, size: 5)
        File.open(log_log(name)) do |log|
          log.extend File::Tail
          log.return_if_eof = true
          log.backward(size).tail(size)
        end
      end

      private_class_method :new

      private

      attr_reader :factory

      def initialize(factory, configuration)
        @factory = factory
        @logs = {}
        log_log!(:console, stream: $stderr)
        log_log!(:main, filename: generic_log_file(:main))
        log_log!(self.class, filter: Regexp.new(self.class.stringify))
      end

    end
  end
end
