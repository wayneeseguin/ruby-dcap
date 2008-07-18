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
    data["user"] = User.get(data["user"]) if data["user"]
    model.create(data)
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
      Dir["db/data/test/*"].each do |file|
        Merb.logger.info "Reading #{file}"
        json = JSON.parse(File.read(file))
        json_to_db(json)
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
