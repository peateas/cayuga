#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'test/test2018/singleton'
require 'test/test2018/named_object'

module ToolInformationHelper
  STRING_SYMBOL_CLASS_EXAMPLES = [{
    string: 'Test2018::Singleton',
    symbol: :'Test2018::Singleton',
    class: Test2018::Singleton,
    filename: 'test2018#singleton'
  }, {
    string: 'Test2018::NamedObject',
    symbol: :'Test2018::NamedObject',
    class: Test2018::NamedObject,
    filename:  'test2018#named_object'
  }].freeze

  NON_CLASS_STRINGS = %W/!@#$% ToolInformationHelper::NON_CLASS_STRINGS/
end