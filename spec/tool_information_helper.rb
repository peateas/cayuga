#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'test/test2018/singleton'
require 'test/test2018/named_object'

module ToolInformationHelper
  STRING_SYMBOL_CLASS_EXAMPLES = [{
    string: 'test2018::singleton',
    alternative_string: 'Test2018::Singleton',
    symbol: :test2018__singleton,
    class: Test2018::Singleton,
    filename: 'test2018__singleton'
  }, {
    string: 'test2018::named-object',
    alternative_string: 'Test2018::NamedObject',
    symbol: :test2018__named_object,
    class: Test2018::NamedObject,
    filename: 'test2018__named_object'
  }].freeze

  NON_CLASS_STRINGS =
    %w[!@#$% ToolInformationHelper::NON_CLASS_STRINGS $_].freeze

  STRING_SYMBOL_EXAMPLES = [{
    string: 'tool-information-helper::NON-CLASS-STRINGS',
    alternative_string: 'ToolInformationHelper::NON_CLASS_STRINGS',
    symbol: :tool_information_helper__NON_CLASS_STRINGS
  }, {
    string:  'a#thing#in#the#universe',
    alternative_string:  'A#Thing#in#the#Universe',
    symbol:  :a___thing___in___the___universe
  }].freeze

end