# frozen_string_literal: true

#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
module Cayuga
  module Utility
    # Cayuga Utility Class
    module Class
      def stringify
        symbolize.stringify
      end

      def symbolize
        # noinspection RubyResolve
        name.methodize.to_sym
      end

      def classify
        self
      end

      def filenamify(extension = nil)
        symbolize.filenamify(extension)
      end

    end
  end
end

Class.include(Cayuga::Utility::Class)

