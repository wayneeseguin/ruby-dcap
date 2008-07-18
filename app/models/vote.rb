class Vote
  include DataMapper::Resource

  property :id, Integer, :serial => true
  property :value, Integer
  
  is :polymorphic, :entity
  
end
