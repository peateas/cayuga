#
# Copyright (c) 2016-2018 Patrick Thomas. All rights reserved.
#
module Cayuga
  module Object
    # Named Object
    module NamedObject
      def self.included(base)
        Object.included(base)
        base.class_eval do
          def self.valid_name?(_factory, name)
            name != nil
          end

          def self.primary?(_name)
            true
          end

          def self.primary(name)
            name
          end

          def self.create(factory, name)
            if primary?(name)
              primary = name
              alternate = nil
            else
              primary = primary(name)
              alternate = name
            end
            verify_name_validity(factory, primary, alternate)
            instance = create_primary(factory, primary(name))
            factory.register(instance, self, alternate) unless alternate.nil?
            instance
          end

          private

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

          def self.create_primary(factory, name)
            if factory.registered?(self, name)
              instance = factory[self, name]
            else
              instance = new(factory, name)
              factory.register(instance, self, name)
            end
            instance
          end

        end
      end

    end
  end
end
