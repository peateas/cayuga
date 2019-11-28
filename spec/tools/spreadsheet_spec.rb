# frozen_string_literal: true

#
# Copyright (c) 2019 Patrick Thomas.  All rights reserved.
#
require 'rspec'

RSpec.describe Cayuga::Tool::SpreadSheet do
  let(:empty_file) { 'spec/test/test2019/empty.xlsx' }
  let(:tokens) { 'spec/test/test2019/tokens.xlsx' }
  let(:data) do
    {
      'letters': %w[A B C D E],
      'numbers': %w[1 2 3 4 5],
      'fruit': %w[apples oranges pears]
    }
  end

  it 'should exist' do
    is_expected.to be_instance_of Cayuga::Tool::SpreadSheet
  end

  it 'should be able to open the empty spreadsheet' do
    is_expected.to respond_to(:fetch).with(1).argument
    # noinspection RubyResolve
    expect(File).to exist(empty_file), "no file #{empty_file}"
    book = subject.fetch(empty_file)
    expect(book).not_to be_nil, "no book #{empty_file}"
    expect(book['sheet']).not_to(
      be_nil,
      "no sheet 'sheet' in book #{empty_file}"
    )
  end

  it 'can read tokens' do
    expect(File).to exist(tokens), "no file #{tokens}"
    book = subject.fetch(tokens)
    expect(book).not_to be_nil, "no book #{tokens}"
    expect(book['tokens']).not_to(
      be_nil,
      "no sheet 'tokens' in book #{tokens}"
    )

  end

end
