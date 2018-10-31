#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
module Cayuga
  module Object
    # Cayuga Object Singleton
    module Singleton
      def self.included(base)
        Object.included(base)
        base.class_eval do
          def self.create(factory)
            raise "#{self.stringify} already registered" if factory.registered?(self)
            factory.register(new(factory), self)
          end
        end
      end
    end
  end
end