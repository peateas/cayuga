#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'cayuga/object/singleton'

module Test2018
  class Singleton
    extend Cayuga::Object::Singleton

    private_class_method :new

    private

    attr_reader :factory

    def initialize(factory)
      @factory = factory
    end

  end
end