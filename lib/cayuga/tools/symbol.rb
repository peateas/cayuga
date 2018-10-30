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
        klass = Object.const_get(self.to_s)
        raise(NameError,"wrong class name '#{klass}'") unless klass.kind_of?(Class)
        klass
      end

      def filenamify(extension=nil)
        stringify.filenamify(extension)
      end

    end
  end
end

Symbol.include(Cayuga::Tools::Symbol)

