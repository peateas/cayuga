#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'cayuga/tools/loggable'
require 'cayuga/object/object'
require 'cayuga/object/singleton'

module Cayuga
  module Object
    class Constants
      include Singleton

      def directory(constant)
        directories[constant.symbolize]
      end

      private_class_method :new

      private

      attr_reader :factory, :directories

      def initialize(factory)
        @factory = factory
        factory[Cayuga::Object::Logger].log_log!(self.class, filename: log_file, filter: Regexp.new("#{self.class.stringify}"))

        @directories = factory.directory_constants
      end

    end
  end
end