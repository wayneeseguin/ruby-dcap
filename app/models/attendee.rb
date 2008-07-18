class Attendee
  include DataMapper::Resource
  
  # link between a user and an event.
  has 1, :user
  has 1, :event
  has n, :votes
end
