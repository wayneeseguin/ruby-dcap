migration(1, :initial) do
  up do
    create_table :events do
      column :id, Integer, :serial => true
      column :name, String, :size => 255
      column :description, DataMapper::Types::Text
    end
    
    create_table :sessions do
      column :id, Integer, :serial => true
      column :name, String, :size => 255
      column :description, DataMapper::Types::Text
      column :event_id, Integer
    end
    
    create_table :comments do
      column :id, Integer, :serial => true
      column :subject, String, :size => 255
      column :message, DataMapper::Types::Text
      column :commentable_class, Class
      column :commentable_id, Integer
      column :user_id, Integer
    end
    
    create_table :attendees do
      column :id, Integer, :serial => true
      column :user_id, Integer
      column :event_id, Integer
    end
    
    create_table :tags do
      column :id, Integer, :serial => true
      column :name, String
      column :taggable_class, Class
      column :taggable_id, Integer
    end
    
    create_table :votes do
      column :id, Integer, :serial => true
      column :value, Integer
      column :attendee_id, Integer
      column :session_id, Integer
    end
    
    create_table :users do
      column :id, Integer, :serial => true
      column :first_name, String
      column :last_name, String
      column :email, String, :size => 255
    end
  end

  down do
    drop_table :events
    drop_table :sessions
    drop_table :comments
    drop_table :attendees
    drop_table :tags
    drop_table :votes
    drop_table :users
  end
end
