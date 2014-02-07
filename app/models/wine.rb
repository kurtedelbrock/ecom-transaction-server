class Wine < CouchRest::Model::Base
  property :uuid, String
  property :wine_id, String
  property :wine_name, String
  property :rating, Integer
  property :comment, String
  
  property :tags, [String]
  
end