#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#

RSpec.describe Cayuga::Tally::Repository, for_tallies: true do
  subject { factory[klass, name] }
  let(:klass) { Cayuga::Tally::Repository }
  let(:constants) { factory[Cayuga::Object::Constants]}
  let(:name) {constants.repository(:test_tallies)}

  it 'should exist' do
    expect(subject).not_to be(nil)
    expect(subject).to be_instance_of(klass)
    # to do:  change to uuid?
    expect(subject).to have_attributes(repository_name: name)
  end

  it 'should be able to name tally values' do
    test_tallies_filename = constants.file(:test_tallies)
    expect(test_tallies_filename).not_to be(nil)
    tallies = JSON.parse(File.read(test_tallies_filename), symbolize_names: true)
    expect(tallies).not_to be(nil)
    tallies.each do |value|
      name = subject.name(value)
      expect(subject).to be_tally(name)
    end

    pending 'implement'
    raise
  end

  it 'should provide name for indirect tallies' do
    big_examples.each do |big|
      name = subject.name(big[:value])
      expect(subject).to be_tally(name)
      #check factors
    end
  end

  it 'should provide factorization for both direct and indirect tallies'


end