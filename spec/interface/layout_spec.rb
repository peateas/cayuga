#
# Copyright (c) 2019 Patrick Thomas.  All rights reserved.
#
require 'test/test2018/web'

RSpec.describe 'interface', :browser do
  subject { browser(Test2018::Web) }
  let(:areas) do
    %w[
      div.page-grid>main div.page-grid>div.left div.page-grid>div.right
      article#main-area-1 article#main-area-2 article#main-area-3
      aside#left-area-1-on aside#left-area-2-on aside#left-area-3-on
      aside#right-area-1-on aside#right-area-2-on aside#right-area-3-on
      aside#left-area-1-off aside#left-area-2-off aside#left-area-3-off
      aside#right-area-1-off aside#right-area-2-off aside#right-area-3-off
    ]
  end
  let(:lists) do
    {
      main_area_1: %w[Julius August Brutus],
      main_area_2: %w[Peter Paul Mary],
      main_area_3: %w[Winston Adolf Franklin],
      left_area_1: %w[uno dos tres],
      left_area_2: %w[einn tveir thrir],
      left_area_3: %w[yi er san],
      right_area_1: %w[alpha beta gamma],
      right_area_2: %w[alef bet gimel],
      right_area_3: %w[asch birith khen]
    }
  end

  it 'should have areas' do
    subject.visit('/')
    areas.each do |area|
      expect(subject).to have_selector(area)
    end
  end

  it 'should have lists' do
    subject.visit('/')
    areas.each do |area|
      case area
        when /\d/
          expect(subject).to have_selector("#{area} ul")
        else
          nil
      end
    end
  end

end
