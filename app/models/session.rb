class Session
  include DataMapper::Resource

  property :id, Integer, :serial => true
  property :name, String, :size => 255
  property :description, DataMapper::Types::Text

  has n, :votes
  has n, :tags
  has n, :comments
  
end
