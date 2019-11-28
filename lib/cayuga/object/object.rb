# frozen_string_literal: true

#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
module Cayuga
  # noinspection RubyConstantNamingConvention
  RootObject = Object

  module Object

    # Cayuga Object Object
    class Object
      include Utility::Loggable

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
        return if self.class == Logger

        factory[Logger]
          .log_log!(self.class, filter: Regexp.new(self.class.name))
      end

    end
  end
end

