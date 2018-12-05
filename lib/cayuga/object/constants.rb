#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'cayuga'

module Cayuga
  module Object
    # noinspection RubyModuleAsSuperclassInspection
    class Constants < Singleton
      def constant(constant)
        constants[constant.symbolize]
      end

      alias [] :constant

      def directory(constant)
        directories[constant.symbolize]
      end

      def file(constant)
        files[constant.symbolize]
      end

      private_class_method :new

      private

      attr_reader :factory, :constants, :directories, :files, :repositories

      def initialize(factory, configuration)
        super
        @constants = configuration[:constants]
        @directories = configuration[:directories]
        @files = configuration[:files]
      end

    end
  end
end