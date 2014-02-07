json.array! (@wines) do |json, wine|
  json.(wine, :uuid, :wine_id, :wine_name, :rating, :comment, :tags)
end