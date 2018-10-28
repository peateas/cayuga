#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#

module Cayuga
  module Tools
    # Cayuga Tools Class
    module Class
      def stringify
        name
      end

      def symbolize
        name.to_sym
      end

      def classify
        self
      end

    end
  end
end

Class.include(Cayuga::Tools::Class)

