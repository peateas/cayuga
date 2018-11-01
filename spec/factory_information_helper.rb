#
# Copyright ©2016-2018 Patrick Thomas. All rights reserved.
#

require 'cayuga'

module FactoryInformationHelper
  CONFIGURATION_INFORMATION = 'spec/test/configuration/cayuga_test_config.json'.freeze
  FACTORY = Cayuga::Object::Factory.new CONFIGURATION_INFORMATION

  def factory
    FACTORY
  end

end
