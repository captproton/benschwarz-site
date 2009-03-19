module Application
  module Web
    helpers do
      include Application::Helpers
    end

    get '/' do
      erb :index
    end
    
    get '/article' do
      erb :article
    end
    
    get '/about' do
      erb :about
    end

    not_found do
      erb :not_found
    end
  end
end