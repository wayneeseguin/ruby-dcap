Gem.clear_paths
Gem.path.unshift(Merb.root / "gems")

dependencies "dm-types", "dm-validations", "dm-polymorphic", "dm-serializer"
dependencies "merb-assets", "merb_helpers", "merb-slices", "merb-action-args"

Merb::BootLoader.after_app_loads do
  # Add dependencies here that must load after the application loads:

  # dependency "magic_admin" # this gem uses the app's model classes
end

use_orm :datamapper
use_test :rspec

Merb::Config.use do |c|

  # Sets up a custom session id key which is used for the session persistence
  # cookie name.  If not specified, defaults to '_session_id'.
  # c[:session_id_key] = '_session_id'
  
  # The session_secret_key is only required for the cookie session store.
  c[:session_secret_key]  = '9c58625dfa6b8c53f7d3bbd7a76169cf69fe8afd'
  
  # There are various options here, by default Merb comes with 'cookie', 
  # 'memory' or 'memcached'.  You can of course use your favorite ORM 
  # instead: 'datamapper', 'sequel' or 'activerecord'.
  c[:session_store] = 'cookie'
end
