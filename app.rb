require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'open-uri'
require 'json'
require 'rdiscount'
require 'smoke'

set :haml, {:format => :html5}

# Require the application libs, core, etc
%w(lib app).each{|path| $:.<< File.join(File.dirname(__FILE__), path) }

# Libs
Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each &method(:require)

# Core
load 'base.rb'
load 'models.rb'
load 'helpers.rb'
load 'web.rb'