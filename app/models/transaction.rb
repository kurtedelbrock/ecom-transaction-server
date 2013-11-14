class Transaction < CouchRest::Model::Base
	include CouchRest::Model::Embeddable
	
  property :transaction_guid, String
	property :product_id, Integer
	property :transaction_timestamp, DateTime
  
  design do
    view :all_transactions, :map => "function(doc) { if (doc.transactions.length) { doc.transactions.forEach(function(transaction) { if (transaction.transaction_guid) { emit(transaction.transaction_guid, transaction); } }); }}"
  end
  
end
