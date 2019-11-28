# frozen_string_literal: true

#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'test/test2019/named_object'

RSpec.describe Test2019::NamedObject do
  subject do
    [
      factory[Test2019::NamedObject, 'name'],
      factory[Test2019::NamedObject, { one: 'first', two: 'second' }]
    ]
  end

  it 'should have simple inspect' do
    subject.each do |object|
      case object.name
        when Hash
          expect(object.inspect).to match(
            /^#<Test2019::NamedObject:\d* @one="first" @two="second">$/
          )
        else
          expect(object.inspect)
            .to match(/^#<Test2019::NamedObject:\d* @name="name">$/)
      end
    end
  end

end
