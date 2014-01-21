class Refund < CouchRest::Model::Base
  include CouchRest::Model::Embeddable
  
  property :amount, Integer
  property :created, Integer
  property :currency, String
  property :balance_transaction, String
  
  def self.ingest_params(params)
    refund = Refund.new
    refund.amount = params[:amount]
    refund.created = params[:created]
    refund.currency = params[:currency]
    refund.balance_transaction = params[:balance_transaction]
    
    return refund
  end
  
end