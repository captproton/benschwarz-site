module Application
  class << self
    attr_reader :config
    
    def new(path_to_config = 'config/app.yml')
      @config_path = path_to_config
      DataMapper.setup(:default, config[:db])
      Sinatra::Application
    end
    
    def config
      @config ||= YAML.load_file(@config_path)[Sinatra::Application.environment]
    end
  end
end