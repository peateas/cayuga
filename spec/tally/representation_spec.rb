#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'cayuga/tally'

RSpec.describe 'representations', for_tallies: true do
  let (:klass) { Cayuga::Tally::Representation }

  specify 'they should have a type' do
    simple_values.each { |value| expect(klass.input_type(value)).to be == :simple }
    simple_hex_values.each { |value| expect(klass.input_type(value)).to be == :simple_hex }
  end

specify 'they belong to a repository'

specify 'they can be created from the repository'

specify 'they can be created with hexadecimal strings'

specify 'they should have names and standardized values'

specify 'they should have standardized string representations'

end