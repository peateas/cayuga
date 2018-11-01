#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
module Cayuga
  module Object
    module Object
      RSpec.describe Object do
        it 'should be able to access the original Object' do
          expect(RootObject).to be_instance_of(Class)
          expect(RootObject).to have_attributes(superclass: BasicObject)
          expect(RootObject.new).to be_a(RootObject)
        end
      end
    end
  end
end
