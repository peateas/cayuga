#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'test2018/singleton'
require 'test2018/named_object_class'

module ToolInformationHelper
  STRING_SYMBOL_CLASS_EXAMPLES = [{
    string: 'Test2018::Singleton',
    symbol: :'Test2018::Singleton',
    class: Test2018::Singleton
  }, {
    string: 'Test2018::NamedObjectClass',
    symbol: :'Test2018::NamedObjectClass',
    class: Test2018::NamedObjectClass
  }].freeze

end