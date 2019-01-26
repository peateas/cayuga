#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'cayuga'

module Test2018
  class LoggingTest
    include Cayuga::Tools::Loggable

    def make_logs
      log.info('info')
      log.debug('debug')
    end

  end
end
