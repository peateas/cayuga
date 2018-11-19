#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'cayuga/tally'

module Cayuga
  module Tally
    module Representation
      # noinspection Annotator
      TYPES = {
        simple: /[,_]\d{3,3}$/,
        simple_hex: /[-_]\h{4,4}$/,
        bitwise: /^<.*>$/,
        factors: /^\[<</,
        list: /^\[\h/,
        attributes: /^\d/,
      }

      def self.input_type(input)
        case input
          when Integer
            :simple
          else
            TYPES.find { |_key, value| value =~ input }[0]
        end
      end

      def standardize_value(input)
        input
      end

    end
  end
end