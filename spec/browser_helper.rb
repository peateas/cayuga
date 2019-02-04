require 'capybara/rspec'

module BrowserHelper
  def browser(application, driver = nil)
    target =
      case driver
        when :headless
          :selenium_chrome_headless
        when :visualize
          :selenium_chrome
        else
          driver = :rack if driver.nil?
          raise "#{driver} is not a browser option" unless driver == :rack

          :rack_test
      end
    browsers[driver][application] ||= Capybara::Session.new(target, application)
  end

  def resize(browser, size: :small)
    window = browser.current_window
    _width, height = window.size
    window.resize_to(breakpoint(size.symbolize)*0.9, height)
    browser
  end

  private

  def browsers
    @browsers ||= { rack: {}, headless: {}, visualize: {} }
  end

  def breakpoint(size)
    case size
      when :small
        640
      else
        1024
    end
  end
end
