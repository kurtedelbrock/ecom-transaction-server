require 'bcrypt'

class User < CouchRest::Model::Base
  property :uuid, String

	property :first_name, String
	property :last_name, String
	
	property :birth_date,	Date
  property :phone_number, String
  
  property :email, String
  property :password, String
  property :token, String
	
	property :wine_api_id, Integer
	
	property :quiz_answers,	QuizAnswer, :array => true
	property :transactions, Transaction, :array => true
  property :wines, Wine, array: true
  
  property :favorite_wine, String
  property :reset_password, TrueClass
  
  validates_uniqueness_of :email
	
	timestamps!
	
	design do
		view :list, :map => "function(doc) { emit (doc._id, doc) }"
    view :by_token, :map => "function(doc) { if (doc.token) { emit(doc.token, doc); } }"
    view :by_email, :map => "function(doc) { if (doc.email !== undefined) { emit(doc.email, doc); } }"
    view :by_uuid, :map => "function(doc) { if (doc.uuid) { emit(doc.uuid, doc); } }"
    view :quiz_answers_by_token, :map => "function(doc) { if (doc.token !== null && doc.token !== undefined) { doc.quiz_answers.forEach(function(entry) { emit([doc.token, entry.question_number], {'question_number': entry.question_number, 'answer_number' :   entry.answer_number}); }); } }", :reduce => "function(keys, values, rereduce) { if (rereduce) { return values.slice(-1)[0]; } else { return values.slice(-1)[0]; } }" 
	end
  
  def find_by_email(email=nil)
    return User.by_email.key(params[:user_id]).first
  end
  
  def find_quiz_answers_by_token(token=nil)
    return nil if token == nil
    return User.quiz_answers_by_token.startkey([token]).endkey([token, {}]).rows
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
  
  def find_wine_by_id(wine_id)
    self.wines.find do |wine|
      wine.uuid == wine_id
    end
  end
	
end
