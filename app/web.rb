module Application
  module Web
    helpers do
      include Application::Helpers
    end

    get '/' do
      @page_id = 'home'
      @stream = Stream.get
      haml :index
    end
    
    get '/article' do
      @page_id = 'article'
      haml :article
    end
    
    get '/about' do
      @page_id = 'about'
      erb :about
    end

    not_found do
      erb :not_found
    end
  end
end