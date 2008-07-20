class Tag
  include DataMapper::Resource
  
  is_polymorphic :taggable
  
  property :id, Integer, :serial => true
  property :name, String
end
