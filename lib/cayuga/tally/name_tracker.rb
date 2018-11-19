#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#

module Cayuga
  module Tally
    class NameTracker < Object::Object
      def sample(value)
        string = trim(value.to_s(16))
        sample = string.slice(0, 2) + string.slice(-3, 3)
        # noinspection RubyArgCount
        sample.to_i(16)
      end

      def trim(string)
        extra = string.size - 5
        extra.times do
          if string.end_with?('0')
            string.chop!
          else
            break
          end
        end
        string
      end
    end

  end
end
