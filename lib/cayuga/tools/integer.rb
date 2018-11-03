#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#

module Cayuga
  module Tools
    module Integer
      def tally_name?
        (0...2 ** 32).include?(self)
      end

      def tally_name_type
        raise ArgumentError, "#{self} not a tally name" unless tally_name?
        case self
          when 0...2 ** 30
            :direct
          when 2 ** 30...2 ** 31
            :meta
          else
            :indirect
        end
      end

      def tally_direct_name?
        tally_name_type == :direct
      end

      def tally_meta_name?
        tally_name_type == :meta
      end

      def tally_indirect_name?
        tally_name_type == :indirect
      end

      def tally_factor
        raise ArgumentError, "#{self} is not a direct tally" unless tally_direct_name?
        0
      end

      def tally_major_value
        raise ArgumentError, "#{self} is not a direct tally" unless tally_direct_name?
        self / 2 ** 16
      end

      def tally_minor_value
        raise ArgumentError, "#{self} is not a direct tally" unless tally_direct_name?
        self % 2 ** 16
      end

    end
  end
end

Integer.include(Cayuga::Tools::Integer)