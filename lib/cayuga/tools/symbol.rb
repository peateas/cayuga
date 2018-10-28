#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#

module Cayuga
  module Tools
    # Cayuga Tools Symbol
    module Symbol
      def stringify
        to_s
      end

      def symbolize
        self
      end

      def classify
        Object.const_get(self.to_s)
      end

    end
  end
end

Symbol.include(Cayuga::Tools::Symbol)

