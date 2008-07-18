class User
  include DataMapper::Resource
  
  property :id, Integer, :key => true, :serial => true
  property :first_name, String
  property :last_name, String
  property :email, String, :size => 255

  has n, :comments
end