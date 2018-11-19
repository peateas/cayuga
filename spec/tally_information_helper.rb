require 'cayuga/tools/integer'
require 'ice_nine'
require 'ice_nine/core_ext/object'
require 'cayuga/tally'

module TallyInformationHelper
  EXAMPLES = [
    { name: -83 },
    { name: -1 },
    { name: 0, type: :direct, factor: 0, major: 0, minor: 0 },
    { name: 2 ** 30 - 1, type: :direct, factor: 0, major: 2 ** 14 - 1, minor: 2 ** 16 - 1 },
    { name: 2 ** 30, type: :meta },
    { name: 2 ** 31 - 1, type: :meta },
    { name: 2 ** 31, type: :indirect },
    { name: 2 ** 32 - 1, type: :indirect },
    { name: 2 ** 32 },
    { name: 2 ** 54 }
  ].freeze

  BIG = [
    [0x4000_0000, 0x40000, [0, 16384, 65535]],
    [0x7FFF_FFFF, 0x7FFFF, [0, 32765, 65535]],
    [0x8000_0000, 0x80000, [0, 65535, 65535]],
    [999_999_999_999_999, 0x38FFF, [1, 232830, 2764472319]],
    [0xFFFF_FFFF_FFFF_FFFF, 0xFFFFF, [1, [0, 65535, 65535], [0, 65535, 65535]]],
    [[65535, 0xFFFF_FFFF_FFFF_FFFF], 0xFFFFF,
      [2, [0, 0, 65535],
        [1, [0, 65535, 65535], [0, 65535, 65535]]]
    ],
    [[0xFFFF_FFFF, 0xFFFF_FFFFF_FFFF_FFFF], 0xFFFFF,
      [2, [0, 65535, 65535],
        [1, [0, 65535, 65535], [0, 65535, 65535]]]
    ],
    [[0xFFFF_FFFF_FFFF_FFFF, 0xFFFF_FFFF_FFFF_FFFF, 0xFFFF_FFFF_FFFF_FFFF], 0xFFFFF,
      [3, [1, [0, 65535, 65535], [0, 65535, 65535]],
        [2, [0, 65535, 65535], [1, [0, 65535, 65535], [0, 65535, 65535]]]]]
  ].deep_freeze

  SIMPLE_VALUES = [
    0,
    2 ** 14 - 1,
    2 ** 14,
    2 ** 15 - 1,
    2 ** 15,
    2 ** 31 - 1,
    2 ** 31,
    2 ** 32 - 1,
    999,
    999_999,
    999_999_999,
    999_999_999_999_999
  ]

  # noinspection SpellCheckingInspection
  SIMPLE_HEX_VALUES = %W/
    FF-FFFF
    ffff-ffff
    FFFF_ffff-Ffff
    Abcd-eFaB_CDEf
    FFFF-FFFF-FFFF-FFFF
  /

  def examples
    EXAMPLES
  end

  def big_examples
    BIG_RECORDS
  end

  def simple_values
    SIMPLE_VALUES
  end

  def simple_hex_values
    SIMPLE_HEX_VALUES
  end

  def self.factorization(factors)
    factor = factors[0]
    major = factors[1]
    minor = factors[2]
    case major
      when Array
        major = factorization(major)
      else
        #nothing_to_do
    end
    case minor
      when Array
        minor = factorization(minor)
      else
      # nothing to do
    end
    { factor: factor, major: major, minor: minor }
  end

  def self.process_big_input(big)
    big.map do |entry|
      value = entry[0]
      sample = entry[1]
      factors = entry[2]
      case value
        when Array
          sum = 0
          value.each do |term|
            sum = sum + 0xFFFF_FFFF_FFFF_FFFF
            sum = sum + term
          end
          value = sum
        else
        # nothing to do
      end
      result = factorization(factors)
      result[:value] = value
      result[:sample] = sample
      result
    end
  end


  BIG_RECORDS = process_big_input(BIG).deep_freeze

end


