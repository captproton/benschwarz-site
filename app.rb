require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'

# Require application dependencies here


# Require the application core
$:.unshift File.join(File.dirname(__FILE__), 'app')

load 'base.rb'
load 'models.rb'
load 'helpers.rb'
load 'web.rb'
