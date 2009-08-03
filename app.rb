__DIR__ = File.dirname(__FILE__)

require 'rubygems'
require 'sinatra'
require 'haml'
require 'rdiscount'
require 'smoke'

%w(helpers stream article haml-filter cache).each{|r| require "#{__DIR__}/lib/#{r}" }
Article.path = "#{__DIR__}/articles"

module Germanforblack
  class Application < Sinatra::Base
    set :haml, {:format => :html5}
    set :public, File.join(File.dirname(__FILE__), 'public')
    enable :static
    
    helpers do
      include Helpers
    end
    
    get '/' do
      cache do
        @twitter = Smoke[:twitter].output.first
        @event = Smoke[:upcoming].output.first
        @links = Smoke[:delicious].output
        @projects = Smoke[:github].output
        @presentations = Smoke[:slideshare].output
        @images = Smoke[:flickr].output
        @articles = Article.all.sort
        
        haml :index
      end
    end
    
    get '/articles/:id' do
      cache do
        @twitter = Smoke[:twitter].output.first
        @event = Smoke[:upcoming].output.first
        @article = Article[params[:id]] || raise(Sinatra::NotFound)
        haml :article
      end
    end

    get '/articles.atom' do
      cache do
        @articles = Article.all.sort
        content_type 'application/atom+xml'
        haml :feed, {:format => :xhtml, :layout => false}
      end
    end
    
    get '/about' do
      cache do
        @twitter = Smoke[:twitter].output.first
        @event = Smoke[:upcoming].output.first
        haml :about
      end
    end

    not_found do
      haml :not_found
    end
  end
end