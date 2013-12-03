require 'bcrypt'

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
  
  def validate_for_transaction(params)
    params[:first_name] && params[:last_name] && params[:shipping_primary_address] && params[:shipping_city] && params[:shipping_zip_code] && params[:email] && params[:password]
  end
  
  def params_have_shipping_address?(params)
    params[:shipping_primary_address] && params[:shipping_city] && params[:zip_code]
  end
  
  def params_have_billing_address?(params)
    params[:billing_primary_address] && params[:billing_city] && params[:billing_zip_code]
  end
  
  def update_from_transaction!(params)
    self.first_name = params[:first_name]
    self.last_name = params[:last_name]
    self.email = params[:email]
  
    self.billing_address = Address.build_billing_address params if self.params_have_billing_address? params
    self.shipping_address = Address.build_shipping_address params
  end
  
  def generate_password!(password)
    self.password = BCrypt::Password.create (password) if password
  end
  
  def generate_token!
    self.token = SecureRandom.hex
  end
	
end
