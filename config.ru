require 'app'
set :environment, :development
set :run, false

# Loads configuration and returns Sinatra::Application. 
# This loads the app into Sinatra
run Application.new 