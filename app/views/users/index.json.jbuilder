json.array! (@users) do |json, user|
	json.(user, :id, :first_name, :last_name, :birth_date, :wine_api_id, :quiz_answers, :shipping_address, :billing_address, :transactions, :updated_at, :created_at)
end