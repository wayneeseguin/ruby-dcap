migration(1, :initial) do
  up do
    create_table :events do
      column :id, Integer, :key => true, :serial => true
      column :name, String, :size => 255
      column :description, DataMapper::Types::Text
    end
    
    create_table :sessions do
      column :id, Integer, :serial => true, :key => true
      column :name, String, :size => 255
      column :description, DataMapper::Types::Text
    end
    
    create_table :comments do
      column :id, Integer, :serial => true, :key => true
      column :subject, String, :size => 255
      column :message, DataMapper::Types::Text
    end
    
    create_table :attendees do
      column :user_id, Integer
      column :event_id, Integer
      column :vote_id, Integer
    end
    
    create_table :tags do
      column :id, Integer, :serial => true, :key => true
      column :name, String
    end
    
    create_table :votes do
      column :id, Integer, :serial => true, :key => true
      column :value, Integer
      column :entity_class, String
      column :entity_id, Integer
    end
    
    create_table :users do
      column :id, Integer, :serial => true, :key => true
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
