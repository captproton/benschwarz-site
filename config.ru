require 'app'
set :environment, :development

# Loads configuration and returns Sinatra::Application. 
# This loads the app into Sinatra
run Application.new 