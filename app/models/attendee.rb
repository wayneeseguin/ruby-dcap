require 'tag'

class Attendee
  include DataMapper::Resource
  
  property :id, Integer, :serial => :true
  
  # link between a user and an event.
  belongs_to :user
  belongs_to :event

  has n, :votes
  has n, :tags, :via => :taggable
end
