require 'rubygems'
require 'sinatra'
require 'haml'
require 'rdiscount'
gem 'smoke', '>= 0.3.9'
require 'smoke'

require 'stream'

module Germanforblack
  class Application < Sinatra::Base
    set :haml, {:format => :html5}
    
    helpers do
      def partial(template, locals={})
        haml("_#{template}".to_sym, :locals => locals, :layout => false)
      end
    end
    
    get '/' do
      @page_id = 'home'
      @stream = Smoke[:stream].output
      haml :index
    end
    
    get '/article' do
      @page_id = 'article'
      haml :article
    end
    
    get '/about' do
      @page_id = 'about'
      haml :about
    end

    not_found do
      haml :not_found
    end
  end
end