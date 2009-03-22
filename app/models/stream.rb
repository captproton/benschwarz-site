class Stream
  include DataMapper::Resource
  
  property :id, Integer, :serial => true
  property :title, String
  property :description, Text
  property :created_at, DateTime
  property :updated_at, DateTime
  property :type, Discriminator
  
  has 1, :source
end

class Link < Stream; end
class Tweet < Stream; end