#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
# noinspection RubyResolve
require 'facets/string/methodize'

module Cayuga
  module Tools
    # Cayuga Tools String
    module String
      def stringify
        self
      end

      def symbolize
        standardize.tr('-', '_').gsub('::', '__').gsub('#', '___').to_sym
      end

      def classify
        symbolize.classify
      end

      def filenamify(extension = nil)
        symbolize.filenamify(extension)
      end

      private

      def alternative?
        match(/[A-Z]/)
      end

      def standardize
        return self unless alternative?
        standardize_string(self)
      end

      def standardize_string(string)
        return string if string.empty?
        string =~ /^([^A-Za-z0-9])?([A-Za-z0-9]+)?(.*)$/
        my_matches = []
        (1..3).each do |i|
          last = Regexp.last_match(i)
          my_matches << (last.nil? ? '' : last)
        end
        my_matches[0] +
          standardize_word(my_matches[1]) +
          standardize_string(my_matches[2])
      end

      def standardize_word(word)
        case word
          when /^([a-z0-9]*)$|^([A-Z0-9][A-Z0-9]+)$/
            word
          else
            # noinspection RubyResolve
            word.methodize
        end
      end

    end

  end
end

String.include(Cayuga::Tools::String)

