require 'cayuga/interface'

module Test2018
  class SinatraRack < Sinatra::Base
    get '/' do
      'Rack'
    end
  end

end
