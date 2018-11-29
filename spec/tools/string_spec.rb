#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
RSpec.describe Cayuga::Tools::String, for_tools: true do

  it 'produces string, symbol and class versions of itself' do
    ToolInformationHelper::STRING_SYMBOL_CLASS_EXAMPLES.each do |example|
      string = example[:string]
      expect(string.stringify).to be == string
      expect(string.symbolize).to be == example[:symbol]
      expect(string.classify).to be == example[:class]
    end
  end

  it 'generates an error when classified if not a class string' do
    ToolInformationHelper::NON_CLASS_STRINGS.each do |string|
      expect { string.classify }.to raise_error(NameError, /wrong .* name/)
    end
  end

  it 'produces a filename version of itself' do
    ToolInformationHelper::STRING_SYMBOL_CLASS_EXAMPLES.each do |example|
      target = example[:string]
      expect(target.filenamify).to be == example[:filename]
    end
  end

end