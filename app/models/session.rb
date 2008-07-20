class Session
  include DataMapper::Resource

  property :id, Integer, :serial => true
  property :name, String, :size => 255
  property :description, DataMapper::Types::Text

  has n, :votes
  has n, :tags, :via => :taggable
  has n, :comments, :via => :commentable
  
  belongs_to :event
end
