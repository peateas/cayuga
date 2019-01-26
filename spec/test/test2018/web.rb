#
# Copyright (c) 2019 Patrick Thomas.  All rights reserved.
#
require 'cayuga/interface'

module Test2018
  class Web < Sinatra::Base
    get '/' do
      File.read('interface/dist/index.html')
    end
  end
end
