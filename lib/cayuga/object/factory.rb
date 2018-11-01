#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'json'
require 'cayuga'

module Cayuga
  module Object
    # Cayuga Object Factory
    class Factory
      include Tools::Loggable

      attr_reader :configuration_information, :logs_directory

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
        unless lookup_registered_instances(key, name).nil?
          value = name.nil? ? klass.string : "#{klass.string}[#{name}]"
          raise "instance for #{value} already registered}"
        end
        type = type(key)
        case type
          when :singleton # , :factory
            instances[key] = instance
          when :named
            value = instances[key]
            if value.nil?
              value = {}
              instances[key] = value
            end
            value[name] = instance
          else
            raise "bad type '#{type}'"
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
        if registered?(key, name)
          type = type(key)
          case type
            when :singleton #, :factory
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
      end

       def directory_constants
         @directories.freeze
       end

      private

      attr_reader :configuration, :types, :instances

      def initialize(config)
        @configuration_information = config
        @configuration = JSON.parse(File.read(config), symbolize_names: true)
        @logs_directory = configuration[:directories][:logs]
        @types = {}
        # register_classes(FACTORIES, :factory)
        register_classes(configuration[:singletons], :singleton)
        # register_classes(INDEXED_CLASSES, :indexed)
        register_classes(
          configuration[:named_object_classes], :named
        )
        @instances = {}
        @directories = configuration[:directories].freeze
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

      def create_instance(type, klass, name)
        case type
          # when :factory
          #   object = klass.create(self, configuration)
          #   unless klass == LoggerFactory
          #     log.info("factory #{klass} created ")
          #   end
          when :singleton
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
