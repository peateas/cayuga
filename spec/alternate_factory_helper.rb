#
# Copyright (c) 2016-2018 Patrick Thomas. All rights reserved.
#
require 'cayuga'

module AlternateFactoryHelper
  ALTERNATIVE_CONFIGURATION_INFORMATION =
    'spec/test/configuration/cayuga_alternate_factory_test_config.json'.freeze
  ALTERNATIVE_FACTORY =
    Cayuga::Object::Factory.new ALTERNATIVE_CONFIGURATION_INFORMATION

  def alternate_factory
    ALTERNATIVE_FACTORY
  end

  def alternate_logger
    @alternate_logger ||= alternate_factory[Cayuga::Object::Logger]
  end

end
