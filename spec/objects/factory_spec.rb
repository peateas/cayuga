#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'test/test2018/object'
require 'test/test2018/singleton'
require 'test/test2018/named_object'

RSpec.describe Cayuga::Object::Factory do
  subject { factory }
  it 'should exist' do
    expect(factory).to be_instance_of Cayuga::Object::Factory
  end

  it 'should have logs directory' do
    expect(factory).not_to have_attributes(logs_directory: nil)
    expect(factory.logs_directory).to be_a String
    expect(factory.logs_directory).not_to be_empty
    expect(Dir).to exist(factory.logs_directory)
  end


  it 'should have registered object classes' do
    expect(factory).to be_supported Test2018::Object
    expect(factory.type(Test2018::Object))
      .to be == :object
  end

  it 'should have registered singleton classes' do
    expect(factory).to be_supported Test2018::Singleton
    expect(factory.type(Test2018::Singleton)).to be == :singleton
  end

  it 'should have registered named object classes' do
    expect(factory).to be_supported Test2018::NamedObject
    expect(factory.type(Test2018::NamedObject))
      .to be == :named
  end

  it 'should provide instances of an object class' do
    one = subject[Test2018::Object]
    two = subject[Test2018::Object]
    expect(one).to be_instance_of Test2018::Object
    expect(two).to be_instance_of Test2018::Object
    expect(one).not_to be(two)
  end

  it 'should provide a single instance of a singleton class' do
    one = subject[Test2018::Singleton]
    two = subject[Test2018::Singleton]
    expect(one).to be_instance_of Test2018::Singleton
    expect(subject).to be_registered(Test2018::Singleton)
    expect(one).to be(two)
  end
  
  it 'should provide a named instance of a named object class' do
    expect(subject[Test2018::NamedObject, :one]).to be_instance_of Test2018::NamedObject
    expect(subject).to be_registered(Test2018::NamedObject, :one)
  end

  it 'should be able to release the singleton instance' do
    expect(subject[Test2018::Singleton]).to be_instance_of Test2018::Singleton
    subject.release(Test2018::Singleton)
    expect(subject).not_to be_registered(Test2018::Singleton)
  end

  it 'should be able to release a named object' do
    expect(subject[Test2018::NamedObject, :one]).to be_instance_of Test2018::NamedObject
    subject.release(Test2018::NamedObject, :one)
    expect(subject).not_to be_registered(Test2018::Singleton)
  end



end