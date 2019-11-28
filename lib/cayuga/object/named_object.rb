# frozen_string_literal: true

#
# Copyright (c) 2016-2018 Patrick Thomas. All rights reserved.
#
module Cayuga
  module Object
    # Named Object
    class NamedObject < Object
      attr_reader :object_name
      alias name object_name

      def self.valid_name?(_factory, name)
        name != nil
      end

      def self.create(factory, configuration, name)
        registered = factory.registered?(self, name)
        raise "#{stringify}[#{name}] already registered" if registered

        valid = valid_name?(factory, name)
        raise "'#{self}['#{name}'] is not a valid #{self}" unless valid

        instance = new(factory, configuration, name)
        factory.register(instance, self, name)
        instance
      end

      def inspect
        case object_name
          when Hash
            result = object_name.map { |key, value| "@#{key}=\"#{value}\"" }
              .join(' ')
            "#<#{self.class.name}:#{object_id} #{result}>"
          else
            "#<#{self.class.name}:#{object_id} @name=\"#{object_name}\">"
        end
      end

      private

      def initialize(factory, configuration, name)
        super(factory, configuration)
        @object_name = name
      end

    end
  end
end
