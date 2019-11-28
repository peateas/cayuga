# frozen_string_literal: true

#
# Copyright (c) 2019 Patrick Thomas.  All rights reserved.
#
require 'rspec'

RSpec.describe Cayuga::Tools::SpreadSheet do
  let(:empty_file) { 'spec/test/test2019/empty.xlsx' }
  it 'should exist' do
    is_expected.to be_instance_of Cayuga::Tools::SpreadSheet
  end

  it 'should be able to open the empty spreadsheet' do
    is_expected.to respond_to(:fetch).with(1).argument
    # noinspection RubyResolve
    expect(File).to exist(empty_file)
    book = subject.fetch(empty_file)
    expect(book).not_to be_nil, "no book #{empty_file}"
    expect(book['sheet']).not_to(
      be_nil,
      "no sheet 'sheet' in book #{empty_file}"
    )
  end

end
