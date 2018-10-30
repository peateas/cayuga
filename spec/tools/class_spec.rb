#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'cayuga/tools/class'

RSpec.describe Cayuga::Tools::Class, for_tools: true do

  it 'produces string, symbol and class versions of itself' do
    ToolInformationHelper::STRING_SYMBOL_CLASS_EXAMPLES.each do |example|
      klass = example[:class]
      expect(klass.stringify).to be == example[:string]
      expect(klass.symbolize).to be == example[:symbol]
      expect(klass.classify).to be == klass
    end
  end

  it 'produces a filename version of itself' do
    ToolInformationHelper::STRING_SYMBOL_CLASS_EXAMPLES.each do |example|
      target = example[:class]
      expect(target.filenamify).to be == example[:filename]
    end
  end

end