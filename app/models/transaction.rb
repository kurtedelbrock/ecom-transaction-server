class Transaction < CouchRest::Model::Base
	include CouchRest::Model::Embeddable
	
  property :transaction_guid, String
	property :product_id, Integer
	property :transaction_timestamp, DateTime
  
  property :first_name, String
  property :last_name, String
  property :phone_number, String
  
	property :shipping_address,	Address
	property :billing_address, Address
  
  property :credit_card_name, String
  
  property :charge, Charge
  
  design do
    view :all_transactions, :map => "function(doc) { if (doc.transactions.length) { doc.transactions.forEach(function(transaction) { if (transaction.transaction_guid) { emit(transaction.transaction_guid, transaction); } }); }}"
  end

  def self.populate_with_automatic_data
    transaction = Transaction.new
    transaction.transaction_timestamp = DateTime.now
    transaction.transaction_guid = SecureRandom.hex
    transaction
  end
  
  def ingest_params(params)
    self.product_id = params[:product_id]
    
    self.first_name = params[:first_name]
    self.last_name = params[:last_name]
    self.phone_number = params[:phone_number]
    
    self.shipping_address = Address.build_shipping_address params
    self.billing_address = Address.build_billing_address params
    
    self.credit_card_name = params[:credit_card_name]
    
  end
  
  def params_have_shipping_address?(params)
    params[:shipping_primary_address] && params[:shipping_city] && params[:zip_code]
  end
  
  def params_have_billing_address?(params)
    params[:billing_primary_address] && params[:billing_city] && params[:billing_zip_code]
  end
end
