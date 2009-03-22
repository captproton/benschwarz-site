class Source
  include DataMapper::Resource
  
  property :id, Integer, :serial => true
  property :name, String
  property :location, String
  
  belongs_to :stream
end