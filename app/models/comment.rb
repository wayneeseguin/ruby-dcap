class Comment
  include DataMapper::Resource

  is :polymorphic, :commentable

  property :id, Integer, :serial => true
  property :subject, String, :size => 255
  property :message, DataMapper::Types::Text

  belongs_to :user
end
