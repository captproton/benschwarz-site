module Application
  module Web
    helpers do
      include Application::Helpers
    end

    get '/' do
      @page_id = 'home'
      @stream = Stream.get
      erb :index
    end
    
    get '/article' do
      @page_id = 'article'
      erb :article
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