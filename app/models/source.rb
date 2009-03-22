class Source
  include DataMapper::Resource
  
  property :id, Integer, :serial => true
  property :name, String
  property :location, String
  property :href, String, :nullable => false
  property :external_id, String
  property :stream_id, Integer
  
  belongs_to :stream
end