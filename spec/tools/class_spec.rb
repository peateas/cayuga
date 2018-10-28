#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'cayuga/tools/class'

RSpec.describe Cayuga::Tools::Class, for_tools: true do

  specify 'switch between strings, symbols and classes' do
    ToolInformationHelper::STRING_SYMBOL_CLASS_EXAMPLES.each do |example|
      klass = example[:class]
      expect(klass.stringify).to be == example[:string]
      expect(klass.symbolize).to be == example[:symbol]
      expect(klass.classify).to be == klass
    end

  end

end