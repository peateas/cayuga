#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'cayuga/tools/string'

RSpec.describe Cayuga::Tools::String, for_tools: true do

  specify 'switch between strings, symbols and classes' do
    ToolInformationHelper::STRING_SYMBOL_CLASS_EXAMPLES.each do |example|
      string = example[:string]
      expect(string.stringify).to be == string
      expect(string.symbolize).to be == example[:symbol]
      expect(string.classify).to be == example[:class]
    end

  end

end