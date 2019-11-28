# frozen_string_literal: true

#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#

RSpec.describe 'factory_missing_configuration' do
  let(:constants) do
    {
      configuration_name: 'Missing Name',
      _constants: {},
      _directories: {},
      _files: {},
      _logs_annotation_marker: '-missing-marker',
      _logs_directory: 'logs'
    }
  end
  let(:keys) do
    {
      configuration_name: 'configuration_name',
      _constants: 'constants',
      _directories: 'directories',
      _files: 'files',
      _logs_annotation_marker: 'log_annotation_marker',
      _logs_directory: 'logs'
    }
  end

  # noinspection RubyBlockToMethodReference
  before(:all) { expect { empty_factory }.not_to raise_exception }

  it 'should have defaults for missing keys' do
    expect(empty_factory).to have_attributes(constants)
  end

  it 'should have logs for missing configurations' do
    expect(records).not_to be_nil, 'no logs for missing configurations'
    expect(records).to have_attributes(size: keys.keys.size)
    list = records.join('\n')
    keys.each do |_constant, key|
      target = /missing key -- {:key=>:#{key}/
      expect(target.match(list)).not_to be_nil,
                                        "no log for missing '#{key}' value"
    end
  end

  def empty_factory
    @empty_factory ||= create_empty_factory
  end

  attr_reader :records

  def create_empty_factory
    result = nil
    klass = Cayuga::Object::Factory
    config = 'spec/test/configuration/empty_factory_config.json'
    log = "logs/#{klass.filenamify('log')}"
    @records = get_logs(log, count: 10) { result = klass.new config }
    result
  end

end
