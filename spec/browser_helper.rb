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

  private

  def browsers
    @browsers ||= { rack: {}, headless: {}, visualize: {} }
  end

end
