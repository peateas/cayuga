# frozen_string_literal: true

#
# Copyright (c) 2019 Patrick Thomas.  All rights reserved.
#
require 'rubyXL'
require 'rubyXL/convenience_methods'

module Cayuga
  module Tool
    # Cayuga Tool SpreadSheet
    class SpreadSheet
      def fetch(book)
        RubyXL::Parser.parse(book)
      end

    end
  end
end
