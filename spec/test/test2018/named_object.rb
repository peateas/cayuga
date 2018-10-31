#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'cayuga/object/object'
require 'cayuga/object/named_object'

module Test2018
  class NamedObject
    include Cayuga::Object::NamedObject

    private_class_method :new

    private

    attr_reader :factory

    def initialize(factory, name)
      @factory = factory
    end

  end
end