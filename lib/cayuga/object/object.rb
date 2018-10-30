#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
#
require 'cayuga/tools/string'
require 'cayuga/tools/symbol'
require 'cayuga/tools/class'
require 'cayuga/tools/loggable'

module Cayuga
  module Object
    module Object
      def log_file
        @log_file ||= "#{factory.logs_directory}/#{self.class.filenamify('.log')}"
      end

    end
  end
end