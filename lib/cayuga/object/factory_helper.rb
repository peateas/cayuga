#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'ice_nine'
require 'ice_nine/core_ext/object'

module Cayuga
  module Object
    # Cayuga Object Factory Helper
    module FactoryHelper
      private

      OBJECTS = {
        singletons: %w[Cayuga::Object::Logger Cayuga::Object::Constants]
      }.deep_freeze

      def setup_types
        @types = {}
        register_classes(configuration[:object_classes], :object)
        register_classes(OBJECTS[:singletons], :singleton)
        register_classes(configuration[:singleton_classes], :singleton)
        register_classes(
          configuration[:named_object_classes], :named
        )
      end

      def register_classes(list, type)
        return if list.nil?
        list.each do |klass|
          types[klass.symbolize] = type
        end
      end

      def lookup_registered_instances(key, name)
        value = instances[key]
        if !value.nil? && !name.nil?
          value = value[name]
        end
        value
      end

      def generate_registration_errors(klass, name, key, type)
        unless lookup_registered_instances(key, name).nil?
          value = name.nil? ? klass.string : "#{klass.string}[#{name}]"
          raise "instance for #{value} already registered}"
        end
        types = %i[singleton named]
        raise "can't register type '#{type}'" unless types.include? type
      end

      def create_instance(type, klass, name)
        case type
          when :object, :singleton
            object = klass.create(self, configuration)
          # log.info("singleton #{klass} created ")
          when :named
            object = klass.create(self, configuration, name)
          # log.info("#{klass} created with name #{name}")
          else
            raise "unregistered or incorrectly registered class #{klass}"
        end
        object
      end
    end
  end
end
