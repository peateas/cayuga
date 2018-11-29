#
# Copyright (c) 2018 Patrick Thomas.  All rights reserved.
#
RSpec.describe 'logging for alternate factories', for_alternate_factory: true do
  # noinspection RubyResolve
  let(:annotation) { alternate_constants[:log_annotation_marker] }
  let(:constants) { factory[Cayuga::Object::Constants] }
  let(:alternate_constants) { alternate_factory[Cayuga::Object::Constants] }
  let(:logs) do
    [
      :console,
      :main,
      factory.class.symbolize,
      logger.class.symbolize
    ]
  end

  specify 'alternate factory exists' do
    expect(defined?(alternate_factory)).to be, 'alternate factory not defined'
    expect(alternate_factory).not_to be_nil, 'no alternate factory'
  end

  specify 'alternate factory has annotation marker' do
    # noinspection RubyResolve
    expect(alternate_constants[:log_annotation_marker]).not_to be_nil,
      'alternate factory has no annotation marker'
  end

  specify 'factory log directories differ' do
    # noinspection RubyResolve
    expect(constants.directory(:logs))
      .not_to be == alternate_constants.directory(:logs)
  end

  specify 'logger has different appender names for each log' do
    expect(logger).to respond_to(:log_appender_name)
    expect(alternate_logger).to respond_to(:log_appender_name)
    logs.each do |name|
      # noinspection RubyResolve
      expect(alternate_logger.log_appender_name(name))
        .to be == logger.log_appender_name(name) + annotation
    end
  end

  specify 'semantic logger has appenders from both factories' do
    constants
    alternate_constants
    names = SemanticLogger.appenders.map(&:name)
    # noinspection RubyResolve
    expect(names).to have_attributes(count: a_value >= 8)
    logs.each do |name|
      # noinspection RubyResolve,RubyResolve
      expect(names).to include(name.stringify, name.stringify + annotation)
    end
  end
end