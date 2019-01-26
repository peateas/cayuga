require 'test/test2018/sinatra_rack'
require 'test/test2018/sinatra_headless'
require 'test/test2018/sinatra_visualize'

RSpec.describe 'browser testing', :browser do
  it 'should be able to open rack test' do
    expect(Test2018::SinatraRack.superclass).to be == Sinatra::Base
    site = browser(Test2018::SinatraRack)
    expect(site).to be_instance_of Capybara::Session
    site.visit('/')
    expect(site.text).to be == 'Rack'
  end

  it 'should be able to open headless browser', :slow do
    expect(Test2018::SinatraHeadless.superclass).to be == Sinatra::Base
    site = browser(Test2018::SinatraHeadless, :headless)
    expect(site).to be_instance_of Capybara::Session
    site.visit('/')
    expect(site.text).to be == 'Headless'
  end

  it 'should be able to open normal browser', :slow do
    expect(Test2018::SinatraVisualize.superclass).to be == Sinatra::Base
    site = browser(Test2018::SinatraVisualize, :visualize)
    expect(site).to be_instance_of Capybara::Session
    site.visit('/')
    expect(site.text).to be == 'Visualize'
  end

end
