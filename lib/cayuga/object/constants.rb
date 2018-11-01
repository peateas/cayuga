#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'cayuga'

module Cayuga
  module Object
    class Constants < Singleton

      def directory(constant)
        directories[constant.symbolize]
      end

      private_class_method :new

      private

      attr_reader :factory, :directories

      def initialize(factory, configuration)
        super
        @directories = configuration[:directories]
      end

    end
  end
end