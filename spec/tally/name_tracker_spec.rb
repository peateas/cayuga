#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
require 'cayuga/tally'

RSpec.describe Cayuga::Tally::NameTracker, for_tallies: true do
  subject { factory[Cayuga::Tally::NameTracker] }
  it 'should exist' do
    expect(subject).not_to be(nil)
    expect(subject).to be_instance_of(Cayuga::Tally::NameTracker)
    expect(subject).to be_a(Cayuga::Object::Object)
  end

  it 'should allow size to be exactly once' do
    pending; raise
    # TO DO:  use parameters in factory hash
    subject.set_size(8)
    expect(subject.size).to be == 8
    expect { subject.set_size=8 }.to raise_exception
  end

  it 'samples value' do
    big_examples.each do |big|
      value = big[:value]
      sample = subject.sample(value)
      expect(4096...2 ** 20).to cover(sample)
      expect(big[:sample]).to be == sample
    end
  end

end
