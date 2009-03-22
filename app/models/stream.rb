class Stream
  include DataMapper::Resource
  
  property :id, Integer, :serial => true
  property :title, String, :nullable => false
  property :description, String
  property :href, String, :nullable => false
  property :permalink, String, :nullable => false
  property :created_at, DateTime
  property :updated_at, DateTime
  property :type, Discriminator
  
  before :valid?, :set_permalink
  
  has 1, :source
  
  private
  
  def set_permalink(context = :default)
    self.permalink = title.gsub(/\s+/, '-')
  end
end