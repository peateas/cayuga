#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'json'
require 'ice_nine'
require 'ice_nine/core_ext/object'
require 'cayuga'
require_relative 'factory_helper.rb'

module Cayuga
  module Object
    # Cayuga Object Factory
    class Factory
      include Cayuga::Object::FactoryHelper
      include Tools::Loggable

      attr_reader :configuration_name, :logs_directory

      def logger
        @logger ||= self[Cayuga::Object::Logger]
      end

      def constants
        @constants ||= self[Cayuga::Object::Constants]
      end

      def supported?(klass)
        types.key?(klass.symbolize)
      end

      def type(klass)
        types[klass.symbolize]
      end

      def registered?(klass, name = nil)
        lookup_registered_instances(klass.symbolize, name) != nil
      end

      def register(instance, klass, name = nil)
        key = klass.symbolize
        type = type(key)
        generate_registration_errors(klass, name, key, type)
        case type
          when :named
            value = instances[key]
            if value.nil?
              value = {}
              instances[key] = value
            end
            value[name] = instance
          else
            instances[key] = instance
        end
        instance
      end

      def [](klass, name = nil)
        key = klass.symbolize
        value = lookup_registered_instances(key, name)
        if value.nil?
          value = create_instance(type(key), klass.classify, name)
        end
        value
      end

      def release(klass, name = nil)
        key = klass.symbolize
        return unless registered?(key, name)
        type = type(key)
        case type
          when :singleton
            instances.delete(key)
          when :named
            value = instances[key]
            if value
              value.delete(name)
            end
          else
            raise "bad type '#{type}'"
        end
      end

      private

      attr_reader :configuration, :types, :instances

      def initialize(config)
        @configuration =
          JSON.parse(File.read(config), symbolize_names: true).deep_freeze
        @configuration_name = configuration[:configuration_name]
        @logs_directory = configuration[:directories][:logs]
        setup_types
        @instances = {}
        @directories = configuration[:directories].freeze
      end

    end
  end
end
