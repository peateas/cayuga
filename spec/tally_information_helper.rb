require 'cayuga/tools/integer'

module TallyInformationHelper
  EXAMPLES = [
    { name: -83 },
    { name: -1 },
    { name: 0, type: :direct, factor: 0, major: 0, minor: 0 },
    { name: 2 ** 30 - 1, type: :direct, factor: 0, major: 2 ** 14 - 1, minor: 2 ** 16 - 1 },
    { name: 2 ** 30, type: :meta },
    { name: 2 ** 31 - 1, type:  :meta },
    { name: 2 ** 31, type:  :indirect },
    { name: 2 ** 32 - 1, type: :indirect},
    { name: 2 ** 32 },
    { name: 2 ** 54 }
  ]

  def examples
    EXAMPLES
  end

end
