#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
RSpec.describe 'tally names', for_tallies: true do
  subject { factory[klass, name] }
  let(:klass) { Cayuga::Tally::Repository }
  let(:constants) { factory[Cayuga::Object::Constants]}
  let(:name) {constants.repository(:test_tallies)}

  specify 'they must be valid' do
    examples.each do |example|
      name = example[:name]
      type = example[:type]
      if type.nil?
        expect(subject).not_to be_name(name)
      else
        expect(subject).to be_name(name)
      end
    end
  end

  specify 'they are direct or meta tallies or indirect name' do
    examples.each do |example|
      name = example[:name]
      type = example[:type]
      if type.nil?
        expect(subject).not_to be_name(name)
      else
        expect(subject).to be_name(name)
      end
    end
  end

  specify 'they are tallies or not' do
    examples.each do |example|
      name = example[:name]
      type = example[:type]
      expect(name).to have_attributes(tally_name_type: type) unless type.nil?
      case type
        when :direct
          expect(name).to have_attributes(
            tally_direct_name?: true,
            tally_meta_name?: false,
            tally_indirect_name?: false
          )
        when :meta
          expect(name).to have_attributes(
            tally_direct_name?: false,
            tally_meta_name?: true,
            tally_indirect_name?: false
          )
        when :indirect
          expect(name).to have_attributes(
            tally_direct_name?: false,
            tally_meta_name?: false,
            tally_indirect_name?: true
          )
        else
          expect { name.tally_name_type }.to raise_exception(ArgumentError, /not a tally name/)
          expect { name.tally_direct_name? }.to raise_exception(ArgumentError, /not a tally name/)
          expect { name.tally_meta_name? }.to raise_exception(ArgumentError, /not a tally name/)
          expect { name.tally_indirect_name? }.to raise_exception(ArgumentError, /not a tally name/)
      end
    end
  end

  specify 'they have factors, major values and minor values' do
    examples.each do |example|
      name = example[:name]
      type = example[:type]
      case type
        when :indirect
          subject.log.warn 'indirect tally factor, major and minor values',
            payload = { value: name.to_s(16) } if type == :indirect
        when :direct #, :indirect
          [:factor, :major, :minor].each do |key|
            message = case key
              when :factor
                "tally_#{key}"
              else
                "tally_#{key}_value"
            end
            expected = example[key]
            got = name.send(message)
            expect(got).to be == expected,
              "#{name} expected #{key} #{expected} got #{got}"
          end
        when :meta
          expect { name.tally_factor }.to raise_exception(ArgumentError, /tally name with no/)
          expect { name.tally_major_value }.to raise_exception(ArgumentError, /tally name with no/)
          expect { name.tally_minor_value }.to raise_exception(ArgumentError, /tally name with no/)
        else
          expect { name.tally_factor }.to raise_exception(ArgumentError, /not a tally name/)
          expect { name.tally_major_value }.to raise_exception(ArgumentError, /not a tally name/)
          expect { name.tally_minor_value }.to raise_exception(ArgumentError, /not a tally name/)
      end
    end
  end

end