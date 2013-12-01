class User < CouchRest::Model::Base
  property :uuid, String

	property :first_name, String
	property :last_name, String
	
	property :birth_date,	Date
  
  property :email, String
  property :password, String
  property :token, String
	
	property :wine_api_id, Integer
	
	property :quiz_answers,	QuizAnswer, :array => true
	property :shipping_address,	Address
	property :billing_address, Address
	property :transactions, Transaction, :array => true
	
	timestamps!
	
	design do
		view :list, :map => "function(doc) { emit (doc._id, doc) }"
    view :by_token, :map => "function(doc) { if (doc.token) { emit(doc.token, doc); } }"
    view :by_email, :map => "function(doc) { if (doc.email) { emit(doc.email, doc); } }"
    view :by_uuid, :map => "function(doc) { if (doc.uuid) { emit(doc.uuid, doc); } }"
	end
  
  def find_by_token(token=nil)
    User.by_token.key(token).rows
  end
  
  def find_by_email(email=nil)
    User.by_email.key(email).rows
  end
	
end
