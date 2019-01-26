require 'cayuga/interface'

module Test2018
  class SinatraHeadless < Sinatra::Base
    get '/' do
      'Headless'
    end
  end

end
