json.array! (@users) do |json, user|
	json.(user, :id, :first_name, :last_name, :birth_date, :wine_api_id, :shipping_address, :billing_address, :transactions, :updated_at, :created_at)
  json.quiz_answers user.quiz_answers do |answer|
    json.question_number answer.question_number
    json.answer_number answer.answer_number
  end
end