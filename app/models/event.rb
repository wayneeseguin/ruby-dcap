class Event
  include DataMapper::Resource

  property :id, Integer, :serial => true
  property :name, String
  property :description, DataMapper::Types::Text
  
  has n, :sessions
  has n, :attendees
  has n, :comments
  
end
