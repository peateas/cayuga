#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'ice_nine'
require 'ice_nine/core_ext/object'

module Cayuga
  module Object
    # Cayuga Object Factory Helper Shared
    module FactoryHelperShared
      private

      def primary_configuration(key, type: Hash)
        if configuration.key? key
          configuration[key]
        else
          log.warn('missing key in configuration', key: key, type: type.name )
          type.new
        end
      end

    end
  end
end
