class Stream
  class << self
    def base
      "http://pipes.yahoo.com/pipes/pipe.run?_id=fHK7LuUW3hGZHgSfbbsjiw&_render=json"
    end
    
    def get
      JSON.parse(open(base).read)["value"]["items"]
    end    
  end
end