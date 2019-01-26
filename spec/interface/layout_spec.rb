#
# Copyright (c) 2019 Patrick Thomas.  All rights reserved.
#
require 'test/test2018/web'

RSpec.describe 'interface', :browser do
  subject { browser(Test2018::Web) }
  let(:areas) do
    %w[
      body
    ]
  end

  it 'should have areas' do
    subject.visit('/')
    areas.each do |area|
      expect(subject).to have_selector(area)
    end
  end

end
