#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'cayuga/object/constants'

RSpec.describe Cayuga::Object::Constants do
  subject { factory[Cayuga::Object::Constants] }
  it 'should have directory location for logs' do
    expect(subject.directory(:logs)).not_to be_empty
  end

end