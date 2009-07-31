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
      
      def entity_encode(string)
        output_array = []
        lower = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
        upper = %w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
        char_array = string.split('')
        char_array.each do |char|  
          output = lower.index(char) + 97 if lower.include?(char)
          output = upper.index(char) + 65 if upper.include?(char)
          if output
            output_array << "&##{output};"
          else 
            output_array << char
          end
        end
        return output_array.join
      end
      
      def ordinalize(number)
        if (11..13).include?(number.to_i % 100)
          "th"
        else
          case number.to_i % 10
            when 1; "st"
            when 2; "nd"
            when 3; "rd"
            else "th"
          end
        end
      end
      
      def article_html(article)
        @article = article
        haml(article.template, :layout => false)
      end
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

    not_found do
      haml :not_found
    end
  end
end