class User < CouchRest::Model::Base

	property :first_name,				String
	property :last_name,					String
	property :wine_api_id,				Integer
	
	property :object_type,							String, :default => "user", :read_only => true
	
	timestamps!
	
end
