class Charge < CouchRest::Model::Base
  include CouchRest::Model::Embeddable
  
  property :id, String
  property :object, String
  property :created, Integer
  property :amount, Integer
  property :card, Card
  property :refunds, Refund, array: true
  property :balance_transaction, String
  property :amount_refunded, String
  property :customer, String
  property :invoice, String
  property :description, String
  
  def self.ingest_params(params)
    charge = Charge.new
    
    charge.id = params[:id]
    charge.object = params[:object]
    charge.created = params[:created]
    charge.amount = params[:amount]
    charge.balance_transaction = params[:balance_transaction]
    charge.amount_refunded = params[:amount_refunded]
    charge.customer = params[:customer]
    charge.invoice = params[:invoice]
    charge.description = params[:description]
    
    charge.card = Card.ingest_params(params)
    charge.refunds = params[:refunds].map do |r|
      Refund.ingest_params(r)
    end
    
    return charge
  end
  
end