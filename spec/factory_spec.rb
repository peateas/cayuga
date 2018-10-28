#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'cayuga/object/factory'
require 'test2018/singleton'
require 'test2018/named_object_class'

RSpec.describe Cayuga::Object::Factory do
  subject { factory }
  it 'should exist' do
    expect(factory).to be_instance_of Cayuga::Object::Factory
  end

  it 'should have registered singletons' do
    expect(factory).to be_supported Test2018::Singleton
    expect(factory.type(Test2018::Singleton)).to be == :singleton
  end

  it 'should have registered named objects' do
    expect(factory).to be_supported Test2018::NamedObjectClass
    expect(factory.type(Test2018::NamedObjectClass))
      .to be == :named
  end

  it 'should provide the instance of a singleton class' do
    expect(subject[Test2018::Singleton]).to be_instance_of Test2018::Singleton
    expect(subject).to be_registered(Test2018::Singleton)
  end

  it 'should provide a named instance of a named object class' do
    expect(subject[Test2018::NamedObjectClass, :one]).to be_instance_of Test2018::NamedObjectClass
    expect(subject).to be_registered(Test2018::NamedObjectClass, :one)
  end

  it 'should be able to release the singleton instance' do
    expect(subject[Test2018::Singleton]).to be_instance_of Test2018::Singleton
    subject.release(Test2018::Singleton)
    expect(subject).not_to be_registered(Test2018::Singleton)
  end

  it 'should be able to release a named object' do
    expect(subject[Test2018::NamedObjectClass, :one]).to be_instance_of Test2018::NamedObjectClass
    subject.release(Test2018::NamedObjectClass, :one)
    expect(subject).not_to be_registered(Test2018::Singleton)
  end

end