#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'test2018/singleton'
require 'test2018/named_object_class'

module ToolInformationHelper
  STRING_SYMBOL_CLASS_EXAMPLES = [{
    string: 'Test2018::Singleton',
    symbol: :'Test2018::Singleton',
    class: Test2018::Singleton,
    filename: 'test2018#singleton'
  }, {
    string: 'Test2018::NamedObjectClass',
    symbol: :'Test2018::NamedObjectClass',
    class: Test2018::NamedObjectClass,
    filename:  'test2018#named_object_class'
  }].freeze

  NON_CLASS_STRINGS = %W/!@#$% ToolInformationHelper::NON_CLASS_STRINGS/
end