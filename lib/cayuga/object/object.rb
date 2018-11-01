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

      private_class_method :new

      private

      attr_reader :factory, :configuration

      def initialize(factory, configuration)
        @factory = factory
        @configuration = configuration
        @configuration_name = configuration[:configuration_name]
      end

    end
  end
end

