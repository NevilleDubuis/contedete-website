# encoding: utf-8
require 'sinatra/base'
require 'pony'

module Application
  class Website < Sinatra::Base
    set :static, true
    set :public_folder, File.expand_path('../../public', __FILE__)
  end
end
