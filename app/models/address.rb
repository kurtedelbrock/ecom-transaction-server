class Address < CouchRest::Model::Base
	include CouchRest::Model::Embeddable
	
	property :street_address, String
	property :secondary_street_address, String
	property :city, String
	property :state, String
	property :zip, Integer
	property :country, String, :default => "USA"
	
	timestamps!
	
  def self.build_address(params, prefix)
    Address.new street_address: params["#{prefix}_primary_address"], secondary_street_address: params["#{prefix}_secondary_address"], city: params["#{prefix}_city"], state: "California", zip: params["#{prefix}_zip_code"]
  end
  
  def self.build_shipping_address(params)
    Address.build_address(params, "shipping")
  end
  
  def self.build_billing_address(params)
    Address.build_address(params, "billing")
  end
  
end
