$:.<< File.join(File.dirname(__FILE__), 'support')

require 'rubygems'
require 'sinatra'
require 'spec'
require 'spec/interop/test'
require 'sinatra/test'
require 'dm-sweatshop'
require 'faker'

root = File.join(File.dirname(__FILE__), '..')

require "#{root}/app.rb"
require "#{root}/spec/support/helpers"

Application.new(File.join(File.dirname(__FILE__), 'support', 'config.yml'))
DataMapper.auto_migrate!

include Application::Spec::Helper

set :environment, :test
set :views, "#{root}/views"
set :public, "#{root}/views"


require 'factory'