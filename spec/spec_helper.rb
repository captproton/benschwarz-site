require 'sinatra'
require 'sinatra/test/rspec'

root = File.join(File.dirname(__FILE__), '..')

require "#{root}/app.rb"

DataMapper.auto_migrate!

set :views, "#{root}/views"
set :public, "#{root}/views"