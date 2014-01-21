class Card < CouchRest::Model::Base
  include CouchRest::Model::Embeddable
  
  property :id, String
  property :object, String
  property :last4, String
  property :card_type, String
  property :exp_month, Integer
  property :exp_year, Integer
  property :fingerprint, String
  property :country, String
  
  def self.ingest_params(params)
    card = Card.new
    card.id = params[:id]
    card.object = params[:object]
    card.last4 = params[:last4]
    card.card_type = params[:type]
    card.exp_month = params[:exp_month]
    card.exp_year = params[:exp_year]
    card.fingerprint = params[:fingerprint]
    card.country = params[:country]
    
    return card
  end
  
end