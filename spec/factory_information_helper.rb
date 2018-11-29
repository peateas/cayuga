#
# Copyright (c) 2016-2018 Patrick Thomas. All rights reserved.
#
require 'cayuga'

module FactoryInformationHelper
  def factory
    FACTORY
  end

  def logger
    @logger ||= factory[Cayuga::Object::Logger]
  end

end
