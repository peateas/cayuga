#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
#
require 'cayuga'

module Cayuga
  # noinspection RubyConstantNamingConvention
  RootObject = Object

  module Object
    class Object
      include Tools::Loggable

      attr_reader :configuration_name

      def self.create(factory, configuration)
        new(factory, configuration)
      end

      private_class_method :new

      private

      attr_reader :factory, :configuration

      def initialize(factory, configuration)
        @factory = factory
        @configuration = configuration
        @configuration_name = factory.configuration_name
        factory[Logger].log_log!(
          self.class,
          filter: Regexp.new(self.class.stringify)
        ) unless self.class == Logger
      end

    end
  end
end

