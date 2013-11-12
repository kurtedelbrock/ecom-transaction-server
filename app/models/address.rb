class Address < CouchRest::Model::Base
	include CouchRest::Model::Embeddable
	
	property :street_address, String
	property :secondary_street_address, String
	property :city, String
	property :state, String
	property :zip, Integer
	property :country, String, :default => "USA"
	
	timestamps!
	
	property :object_type, String, :default => "address", :read_only => true
	
end
