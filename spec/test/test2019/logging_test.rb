# frozen_string_literal: true

#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'cayuga'

module Test2019
  class LoggingTest
    include Cayuga::Utility::Loggable

    def make_logs
      log.info('info')
      log.debug('debug')
    end

  end
end
