#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'cayuga/tools/loggable'
require 'semantic_logger'

class LoggingTestClass
  include Cayuga::Tools::Loggable

  def make_logs
    log.info('info')
    log.debug('debug')
  end

end