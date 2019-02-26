#
# Copyright (c) 2019 Patrick Thomas.  All rights reserved.
#
require 'cayuga'
require 'cayuga/interface'

module Test2018
  class Web < Sinatra::Base
    configure do
      config = 'spec/test/configuration/cayuga_test_web_config.json'
      factory = Cayuga::Object::Factory.new(config)
      folder = File.expand_path('interface/dist')
      set public_folder: folder
      set factory: factory
      factory[Cayuga::Object::Logger]
      factory[Cayuga::Object::Constants]
    end

    def factory
      @factory ||= settings.factory
    end

    def source
      @source ||= factory.constants.file(:interface_test_lists)
    end

    def lists
      @lists ||= JSON.parse(File.read(source), symbolize_names: true)
    end

    get '/' do
      File.read('interface/dist/index.html')
    end

    get '/lists/:primary/:secondary' do
      primary = params['primary'].symbolize
      secondary = params['secondary'].symbolize
      JSON.generate(lists[primary][secondary])
    end

    get '/lists/:primary' do
      JSON.generate(lists[params['primary'].symbolize])
    end

    get '/lists' do
      JSON.generate(lists)
    end

    # noinspection RubyResolve
    run! if app_file == $PROGRAM_NAME
  end
end
