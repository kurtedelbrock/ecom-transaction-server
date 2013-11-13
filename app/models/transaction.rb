class Transaction < CouchRest::Model::Base
	include CouchRest::Model::Embeddable
	
  property :transaction_guid, String
	property :product_id, Integer
	property :transaction_timestamp, DateTime
	
end
