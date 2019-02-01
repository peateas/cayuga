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

      def self.primary?(_name)
        true
      end

      def self.primary(name)
        name
      end

      def self.create(factory, configuration, name)
        if factory.registered?(self, name)
          raise "#{stringify}[#{name}] already registered"
        end

        if primary?(name)
          primary = name
          alternate = nil
        else
          primary = primary(name)
          alternate = name
        end
        verify_name_validity(factory, primary, alternate)
        instance = create_primary(factory, configuration, primary(name))
        factory.register(instance, self, alternate) unless alternate.nil?
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
        # TO DO: alternative names
      end

      def self.verify_name_validity(factory, name, alternate)
        # check validity of name
        unless valid_name?(factory, name)
          raise "'#{self}['#{name}'] is not a valid #{self}"
        end

        # name valid
        # check alternate valid if exists
        unless alternate.nil?
          unless valid_name?(factory, alternate)
            raise "'#{self}['#{alternate}'] is not a valid #{self}"
          end
        end
        # alternate valid
        true
      end

      private_class_method :verify_name_validity

      def self.create_primary(factory, configuration, name)
        if factory.registered?(self, name)
          instance = factory[self, name]
        else
          instance = new(factory, configuration, name)
          factory.register(instance, self, name)
        end
        instance
      end

      private_class_method :create_primary

    end
  end
end
