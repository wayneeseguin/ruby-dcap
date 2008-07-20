require "erubis"
require "json"

def connect()
  ENV["MERB_ENV"] ||= "development"
  Merb.start_environment :adapter => "runner", :environment => ENV["MERB_ENV"]
  @database = ::DataMapper.repository.adapter
  Merb.logger.info "Connected to the database"
end

def json_to_db(json)
  connect()
  Merb.logger.info "Importing #{json.inspect}"
  model = Kernel.const_get(json["model"])

  json["data"].each do |data|
    # puts "???? #{data.inspect}"
    data["user"] = User.get(data["user"]) if data["user"]
    # puts "&&& #{data['user'].inspect}"
    res = model.create(data)
    # puts ">>> #{res.inspect}"
  end
end

namespace :app do

  desc "Install (gems) and bootstrap DB (Note: Must have database.yml configured properly first)"
  task :install => ["app:gems:install", "app:db:reset"]

  namespace :db do

    desc "Load initial data"
    task :load_initial_data do
      Dir["db/data/initial/*"].each do |file|
        Merb.logger.info("Reading #{file}")
        json = JSON.parse(File.read(file))
        json_to_db(json)
      end
    end

    desc "Load test data"
    task :load_test_data do
      $LOAD_PATH << File.join(File.dirname(__FILE__), "..", "..", "app", "models")
      Dir["app/models/*.rb"].each do |file|
        require file
      end
      Dir["db/data/test/*"].each do |file|
        next if file =~ /\.json$/
        require file
        # Merb.logger.info "Reading #{file}"
        # json = JSON.parse(File.read(file))
        # TODO: Iterate through JSON loading objects without relationships
        # TODO: Iterate through JSON loading relationships for each object
          # TODO: Look at the associated Resource's properties to determine the primary key field(s)
        # json_to_db(json)
      end
    end

    desc "Reset: Drop all tables, migrate up, load initial schema."
    task :reset do
      Rake::Task["app:db:drop_tables"].invoke
      Rake::Task["dm:db:migrate:up"].invoke
      Rake::Task["app:db:load_initial_data"].invoke
    end

    desc "Drop all tables"
    task :drop_tables do
      connect();
      if Merb.env != "development"
        puts"Reset is only allowed in the development environment."
        exit
      end
      models = ::DataMapper::Resource.descendants
      models.each do |model|
        Merb.logger.info "dropping #{model.storage_name.to_s}"
        @database.destroy_model_storage(::DataMapper.repository, model)
      end
      @database.execute("DROP TABLE migration_info") rescue nil

      Merb.logger.info "All tables corresponding to models within the current application have been droped."
    end

  end
  
  namespace :gems do
    task :yaml do
      @gems = Erubis.load_yaml_file(Merb.root + "/config/gems.yml")
    end
    
    desc "Install required gems"
    task :install => [:yaml] do
      # TODO
    end
    
    desc "Update required gems"
    task :update => [:yaml] do
      # TODO
    end
  end
  
end
