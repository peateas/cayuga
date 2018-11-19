#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'cayuga/object/named_object'

module Cayuga
  module Tally
    class Repository < Object::NamedObject
      alias repository_name name

      def name?(name)
        name.tally_name?
      end

      def name(value)
        target = standardize(value)
        name = values[target]
        return name unless name.nil?
        name = generate_name_for_value(target)
        add(name, target)
        name
      end

      def tally?(name)
        !name.tally_indirect_name? || tallies.key?(name)
      end

      def tally(_name)
      end

      alias :[] :tally

      private

      attr_reader :tallies, :values

      def initialize(factory, configuration, name)
        super(factory, configuration, name)
        @tallies = {}
        @values = {}
      end

      def factorize(value)
        case value.size
          when 4
            { factor: 0, major: value / 2 ** 16, minor: value % 2 ** 16 }
          else
            raise ArgumentError, "factorization for #{value} not supported (yet?)"
        end
      end

      def standardize(value)
        case value
          when Array
            raise NotImplementedError, 'need to implement standardization of array values'
          else
            factorize(value)
        end
      end


      def generate_name_for_value(_standardize_value)
        0
      end

      def add(_name, _standard_value)
      end

    end
  end
end