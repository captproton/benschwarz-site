__DIR__ = File.dirname(__FILE__)

require 'rubygems'
require 'sinatra'
require 'haml'
require 'rdiscount'
require 'smoke'

%w(helpers stream article haml-filter).each{|r| require "#{__DIR__}/lib/#{r}" }
Article.path = "#{__DIR__}/articles"

module Germanforblack
  class Application < Sinatra::Base
    set :haml, {:format => :html5}
    set :public, File.join(File.dirname(__FILE__), 'public')
    enable :static
    
    helpers do
      include Helpers
    end
    
    before do
      @twitter = Smoke[:twitter].output.first
      @event = Smoke[:upcoming].output.first
    end
    
    get '/' do
      @page_id = 'home'
      @links = Smoke[:delicious].output
      @projects = Smoke[:github].output
      @presentations = Smoke[:slideshare].output
      @images = Smoke[:flickr].output
      @articles = Article.all.sort
      
      haml :index
    end
    
    get '/article' do
      @page_id = 'article'
      haml :article
    end
    
    get '/articles/:id' do
      @article = Article[params[:id]] || raise(Sinatra::NotFound)
      haml :article
    end

    get '/articles.atom' do
      @articles = Article.all.sort
      content_type 'application/atom+xml'
      haml :feed, :layout => false
    end
    
    get '/about' do
      haml :about
    end

    not_found do
      haml :not_found
    end
  end
end