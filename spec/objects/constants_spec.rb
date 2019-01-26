#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
RSpec.describe Cayuga::Object::Constants do
  subject { factory[Cayuga::Object::Constants] }
  it 'should have constants' do
    expect(subject[:test_constant]).to be == 'test_constant'
  end

  it 'should have directories' do
    expect(subject.directory(:test_directory)).to be == 'test_directory'
  end

  it 'should have files' do
    expect(subject.file(:test_file)).to be == 'test_file'
  end

end
