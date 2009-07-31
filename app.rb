__DIR__ = File.dirname(__FILE__)

require 'rubygems'
require 'sinatra'
require 'haml'
require 'rdiscount'
require 'smoke'

require "#{__DIR__}/lib/stream"
require "#{__DIR__}/lib/article"
Article.path = "#{__DIR__}/articles"

module Germanforblack
  class Application < Sinatra::Base
    set :haml, {:format => :html5}
    set :public, File.join(File.dirname(__FILE__), 'public')
    enable :static
    
    helpers do
      def partial(template, locals={})
        haml("_#{template}".to_sym, :locals => locals, :layout => false)
      end
      
      def article_path(article)
        "/articles/#{article.slug}"
      end
      
      def flickr_url(photo)
        "http://flickr.com/photos/benschwarz/#{photo[:id]}"
      end
    end
    
    get '/' do
      @page_id = 'home'
      
      @links = Smoke[:delicious].output
      @event = Smoke[:upcoming].output 
      @projects = Smoke[:github].output
      @presentations = Smoke[:slideshare].output
      @twitter = Smoke[:twitter].output
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

    not_found do
      haml :not_found
    end
  end
end