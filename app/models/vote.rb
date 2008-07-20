class Vote
  include DataMapper::Resource

  property :id, Integer, :serial => true
  property :value, Integer

  belongs_to :attendee
  belongs_to :session
end
