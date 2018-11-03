#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
RSpec.describe Integer, for_tallies: true do
  specify 'tally names must be in range' do
    examples.each do |example|
      name = example[:name]
      if example[:type].nil?
        expect(name).not_to be_tally_name
      else
        expect(example[:name]).to be_tally_name
      end
    end
  end

  specify 'tally_names are names for direct or meta tallies or are indirect tally names' do
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
      if example[:type].nil?
      else

      end
    end
  end

  specify 'direct tally names have factors, major values and minor values' do
    examples.each do |example|
      name = example[:name]
      type = example[:type]
      case type
        when :direct
          [:factor, :major, :minor].each do |key|
            message = case key
              when :factor
                "tally_#{key}"
              else
                "tally_#{key}_value"
            end
            expected = example[key]
            got = name.send(message)
            expect(expected).to be == got,
              "#{name} expected #{key} #{expected} got #{got}"
          end
        when :meta, :indirect
          expect { name.tally_factor }.to raise_exception(ArgumentError, /not a direct tally/)
          expect { name.tally_major_value }.to raise_exception(ArgumentError, /not a direct tally/)
          expect { name.tally_minor_value }.to raise_exception(ArgumentError, /not a direct tally/)
        else
          expect { name.tally_factor }.to raise_exception(ArgumentError, /not a tally name/)
          expect { name.tally_major_value }.to raise_exception(ArgumentError, /not a tally name/)
          expect { name.tally_minor_value }.to raise_exception(ArgumentError, /not a tally name/)
      end
    end
  end

end
