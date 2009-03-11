Dir["#{File.dirname(__FILE__)}/helpers/*.rb"].each &method(:require)

module Application
  module Helpers
    # Include your helper modules here
    
    include Utils
  end
end