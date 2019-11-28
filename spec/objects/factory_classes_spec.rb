# frozen_string_literal: true

#
# Copyright (c) 2019 Patrick Thomas.  All rights reserved.
#
require 'test/test2019/object'
require 'test/test2019/singleton'
require 'test/test2019/named_object'

RSpec.describe Cayuga::Object::Factory do
  # noinspection RubyBlockToMethodReference
  subject { factory }

  it 'determines if class is supported' do
    is_expected.to respond_to(:supported?).with(1).argument
    is_expected.to be_supported(Test2019::Object)
    is_expected.to be_supported(Test2019::Singleton)
    is_expected.to be_supported(Test2019::NamedObject)
    is_expected.not_to be_supported(Cayuga::Object::Factory)

  end

  it 'registers and deregisters classes as singleton or named object' do
    is_expected.to respond_to(:register_class).with(2).arguments
    # is_expected.to respond_to(:deregister_class).with(1).argument
    check_class_registration(Test2019::Object, :object)
    check_class_registration(Test2019::Singleton, :singleton)
    check_class_registration(Test2019::NamedObject, :named)
  end

  # noinspection RubyResolve
  def check_class_registration(klass, type)
    subject.send(:deregister_class, klass)
    is_expected.not_to be_supported(klass)
    subject.register_class(klass, type)
    is_expected.to be_supported(klass)
  end

end
