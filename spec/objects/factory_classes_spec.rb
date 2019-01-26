#
# Copyright (c) 2019 Patrick Thomas.  All rights reserved.
#
require 'test/test2018/object'
require 'test/test2018/singleton'
require 'test/test2018/named_object'

RSpec.describe Cayuga::Object::Factory do
  # noinspection RubyBlockToMethodReference
  subject { factory }

  it 'determines if class is registered' do
    is_expected.to respond_to(:registered_class?).with(1).argument
    is_expected.to be_registered_class(Test2018::Object)
    is_expected.to be_registered_class(Test2018::Singleton)
    is_expected.to be_registered_class(Test2018::NamedObject)
    is_expected.not_to be_registered_class(Cayuga::Object::Factory)

  end

  it 'registers and deregisters classes as singleton or named object' do
    is_expected.to respond_to(:register_class).with(2).arguments
    is_expected.to respond_to(:deregister_class).with(1).argument
    check_class_registration(Test2018::Object, :object)
    check_class_registration(Test2018::Singleton, :singleton)
    check_class_registration(Test2018::NamedObject, :named)
  end

  # noinspection RubyResolve
  def check_class_registration(klass, type)
    subject.deregister_class(klass)
    is_expected.not_to be_registered_class(klass)
    subject.register_class(klass, type)
    is_expected.to be_registered_class(klass)
  end

end
