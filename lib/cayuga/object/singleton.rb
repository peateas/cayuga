#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
module Cayuga
  module Object
    # Cayuga Object Singleton
    class Singleton < Object
      def self.create(factory, configuration)
        raise "#{self.stringify} already registered" if factory.registered?(self)
        factory.register(new(factory, configuration), self)
      end
    end
  end
end
