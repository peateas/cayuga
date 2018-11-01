#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
#
# require 'cayuga/tools/string'
# require 'cayuga/tools/symbol'
# require 'cayuga/tools/class'
require 'cayuga/tools/loggable'

module Cayuga
  # noinspection RubyConstantNamingConvention
  RootObject = Object

  module Object
    module Object
      def self.included(base)
        Tools::Loggable.included(base)
        base.class_eval do
        end
      end
    end
  end

end