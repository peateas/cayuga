#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
# noinspection RubyResolve
require 'facets/string/pathize'

require 'file-tail'

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
        symbolize.classify
      end

      def filenamify(extension = nil)
        # noinspection RubyResolve
        result = pathize.gsub('/', '#')
        unless extension.nil? || extension.empty?
          result += extension[0] == '.' ? '' : '.'
          result += extension.stringify
        end
        result
      end

    end
  end
end

String.include(Cayuga::Tools::String)

