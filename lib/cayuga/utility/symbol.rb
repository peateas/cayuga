# frozen_string_literal: true

#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
# noinspection RubyResolve
require 'facets/string/modulize'

module Cayuga
  module Utility
    # Cayuga Tools Symbol
    module Symbol
      def stringify
        to_s.gsub('___', '#').gsub('__', '::').tr('_', '-')
      end

      def symbolize
        self
      end

      def classify
        # noinspection RubyResolve
        klass = RootObject.const_get(to_s.modulize)
        raise NameError, "wrong class name '#{klass}'" unless klass.is_a?(Class)

        klass
      end

      def filenamify(extension = nil)
        # noinspection RubyResolve
        result = to_s
        unless extension.nil? || extension.empty?
          result += extension[0] == '.' ? '' : '.'
          result += extension.stringify
        end
        result
      end

    end
  end
end

Symbol.include(Cayuga::Utility::Symbol)

