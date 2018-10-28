#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#

module Cayuga
  module Tools
    # Cayuga Tools String
    module String
      def stringify
        self
      end

      def symbolize
        to_sym
      end

      def classify
        Object.const_get(self)
      end

    end
  end
end

String.include(Cayuga::Tools::String)

