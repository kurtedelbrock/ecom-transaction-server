class User < CouchRest::Model::Base

	property :first_name,				String
	property :last_name,					String
	property :wine_api_id,				Integer
	
	timestamps!
	
end
