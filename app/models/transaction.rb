class Transaction < CouchRest::Model::Base
	include CouchRest::Model::Embeddable
	
	property :product_id, Integer
	property :transaction_timestamp, DateTime
	
end
