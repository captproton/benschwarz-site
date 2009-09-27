__DIR__ = File.dirname(__FILE__)

require 'lib/core_ext/enumerable'
require 'sinatra'
require 'rdiscount'
require 'json'
require 'crack'
require 'moneta'
require 'haml'
gem 'smoke', '0.5.13'
require 'smoke'

%w(helpers stream article haml-filter).each{|r| require "#{__DIR__}/lib/#{r}" }
Article.path = "#{__DIR__}/articles"

module Germanforblack
  class Application < Sinatra::Base
    set :logging, true
    set :public, File.join(File.dirname(__FILE__), 'public')
    set :haml, {:format => :html5, :attr_wrapper => '"'}
    enable :static
    
    helpers do
      include Helpers
    end
      
    get '/' do
      @event = Smoke[:upcoming].output.first
      @image = Smoke[:flickr].output.sort_by{rand}.first
      @links = Smoke[:delicious].output
      @projects = Smoke[:github].output
      @presentations = Smoke[:slideshare].output
      @articles = Article.all.sort[0..1]
      
      haml :index
    end
    
    get '/articles/:id' do
      @twitter = Smoke[:twitter].output.first
      @event = Smoke[:upcoming].output.first
      @article = Article[params[:id]] || raise(Sinatra::NotFound)
      haml :article, {:layout => :inner_layout}
    end

    get '/articles' do
      @twitter = Smoke[:twitter].output.first
      @event = Smoke[:upcoming].output.first
      @articles = Article.all.sort
      haml :articles
    end

    get '/articles.atom' do
      @articles = Article.all.sort
      content_type 'application/atom+xml'
      haml :feed, {:format => :xhtml, :layout => false}
    end
    
    get '/about' do
      @twitter = Smoke[:twitter].output.first
      @event = Smoke[:upcoming].output.first
      haml :about
    end

    get '/clear-cache' do
      Smoke::Cache.clear!
      "Done"
    end

    not_found do
      haml :not_found, {:layout => :plain}
    end
    
    error(500..599) do
      haml :application_errors, {:layout => :plain}
    end
  end
end