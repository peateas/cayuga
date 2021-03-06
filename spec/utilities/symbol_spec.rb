# frozen_string_literal: true

#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
RSpec.describe Cayuga::Utility::Symbol, :tools do

  it 'produces string, symbol and class versions of itself' do
    ToolInformationHelper::STRING_SYMBOL_CLASS_EXAMPLES.each do |example|
      symbol = example[:symbol]
      expect(symbol.stringify).to be == example[:string]
      expect(symbol.symbolize).to be == symbol
      expect(symbol.classify).to be == example[:class]
    end
  end

  it 'generates an error when classified if not a class string' do
    ToolInformationHelper::NON_CLASS_STRINGS.each do |string|
      expect { string.symbolize.classify }
        .to raise_error(NameError, /wrong .* name/)
    end
  end

  it 'produces a filename version of itself' do
    ToolInformationHelper::STRING_SYMBOL_CLASS_EXAMPLES.each do |example|
      target = example[:symbol]
      expect(target.filenamify).to be == example[:filename]
    end
  end

  it 'handles other strings' do
    ToolInformationHelper::STRING_SYMBOL_EXAMPLES.each do |example|
      symbol = example[:symbol]
      expect(symbol.stringify).to be == example[:string]
    end
  end

end
