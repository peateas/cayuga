# frozen_string_literal: true

#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'test/test2019/singleton'
require 'test/test2019/named_object'

module ToolInformationHelper
  STRING_SYMBOL_CLASS_EXAMPLES = [{
    string: 'test2019::singleton',
    alternative_string: 'Test2019::Singleton',
    symbol: :test2019__singleton,
    class: Test2019::Singleton,
    filename: 'test2019__singleton'
  }, {
    string: 'test2019::named-object',
    alternative_string: 'test2019::NamedObject',
    symbol: :test2019__named_object,
    class: Test2019::NamedObject,
    filename: 'test2019__named_object'
  }].freeze

  NON_CLASS_STRINGS =
    %w[!@#$% ToolInformationHelper::NON_CLASS_STRINGS $_].freeze

  STRING_SYMBOL_EXAMPLES = [{
    string: 'tool-information-helper::NON-CLASS-STRINGS',
    alternative_string: 'ToolInformationHelper::NON_CLASS_STRINGS',
    symbol: :tool_information_helper__NON_CLASS_STRINGS
  }, {
    string: 'a#thing#in#the#universe',
    alternative_string: 'A#Thing#in#the#Universe',
    symbol: :a___thing___in___the___universe
  }].freeze

end
