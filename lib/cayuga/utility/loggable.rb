# frozen_string_literal: true

#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
# noinspection RubyResolve
require 'semantic_logger'

module Cayuga
  module Utility
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
            filenamify('.log')
          end

        end
      end
    end
  end
end
