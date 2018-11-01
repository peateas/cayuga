#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'semantic_logger'

module Cayuga
  module Tools
    # Cayuga Tools Loggable
    module Loggable
      def self.included(base)
        SemanticLogger::Loggable.included(base)
        base.class_eval do
          class << self
            alias_method :log, :logger
          end

          alias_method :log, :logger

          def self.log_file
            "#{self.filenamify('.log')}"
          end

        end
      end
    end
  end
end
