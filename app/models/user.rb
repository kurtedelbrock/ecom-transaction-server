class User < CouchRest::Model::Base

	property :first_name,				String
	property :last_name,					String
	property :wine_api_id,				Integer
	
	property :quiz_answers,			QuizAnswer, :array => true
	property :shipping_address, 	Address
	property :billing_address, 	Address
	
	timestamps!
	
end
