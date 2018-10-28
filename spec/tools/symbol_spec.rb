#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'cayuga/tools/symbol'

RSpec.describe Cayuga::Tools::Symbol, for_tools: true do

  specify 'switch between strings, symbols and classes' do
    ToolInformationHelper::STRING_SYMBOL_CLASS_EXAMPLES.each do |example|
      symbol = example[:symbol]
      expect(symbol.stringify).to be == example[:string]
      expect(symbol.symbolize).to be == symbol
      expect(symbol.classify).to be == example[:class]
    end

  end

end