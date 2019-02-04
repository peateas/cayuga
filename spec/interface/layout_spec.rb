#
# Copyright (c) 2019 Patrick Thomas.  All rights reserved.
#
require 'test/test2018/web'

RSpec.describe 'interface', :browser do
  subject { browser(Test2018::Web) }
  let(:js) { browser(Test2018::Web, :headless) }
  # let(:js) { browser(Test2018::Web, :visualize) }
  let(:sections) do
    %w[.page-on>main .page-on>div.left .page-on>div.right]
  end
  let(:source_list) { factory.constants.file(:interface_test_lists) }
  let(:lists) { JSON.parse(File.read(source_list), symbolize_names: true) }
  let(:keys) do
    {
      names: %i[roman christian political],
      numbers: %i[spanish icelandic mandarin],
      letters: %i[greek hebrew runes]
    }
  end
  let(:list_types) { %w[simple dropdown duo multiple] }
  let(:areas) do
    {
      main: {
        christian: [:full, :dropdown, '/lists/names/christian']
      },
      right: {
        greek: [:full, :dropdown, '/lists/letters/greek']
      }
    }
  end

  it 'should have page on canvas sections' do
    subject.visit('/')
    sections.each do |area|
      expect(subject).to have_selector(area)
    end
  end

  it 'should have target data' do
    expect(source_list).not_to be_nil, 'no source lists'
    expect(lists).not_to be(nil), 'no lists'
    expect(lists).to be_a(Hash)
    # noinspection RubyResolve
    expect(lists.keys).to include(:names, :numbers, :letters)
    lists.values.each do |secondary|
      # noinspection RubyResolve
      expect(secondary).to be_a(Hash)
      expect(secondary.keys).to have_attributes(size: 3)
      secondary.values.each do |value|
        expect(value).to be_an(Array)
        expect(secondary.keys).to have_attributes(size: 3)
      end
    end
  end

  it 'should have target lists' do
    keys.each do |primary, value|
      value.each do |secondary|
        subject.visit("/lists/#{primary}/#{secondary}")
        data = nil
        expect do
          data = JSON.parse(subject.text, symbolize_names: true)
        end.not_to raise_exception
        # noinspection RubyResolve
        expect(data).to include(*lists[primary][secondary])
      end
    end
  end

  it 'should have target areas' do
    js.visit('/')
    areas.each do |section, area|
      area.each do |name, _list|
        expect(js).to have_selector(element(section, name))
        next if section == :main

        resize(js, size: 'small')
        button = button(section, name)
        expect(js).to have_selector(button)
        js.find(button).click
        expect(js).to have_selector(element(section, name, on: false))
      end
    end
  end

  it 'should have lists' do
    js.visit('/')
    areas.each do |section, area|
      area.each do |name, _list|
        expect(js).to have_selector("#{element(section, name)} ul")
        next if section == :main

        resize(js)
        button = button(section, name)
        expect(js).to have_selector(button)
        js.find(button).click
        selector = "#{element(section, name, on: false)} ul"
        expect(js).to have_selector(selector)
      end
    end
  end

  def element(section, name, on: true)
    base = "##{section.stringify}-area-#{name}"
    case section
      when :main
        'article' + base
      else
        if on
          "aside.area-on#{base}-on"
        else
          "aside.#{section}-area-off#{base}-off"
        end
    end
  end

  def button(section, name)
    "button.aside##{section.stringify}-button-#{name}"
  end

end
