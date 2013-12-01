json.array! (@users) do |json, user|
	json.(user, :id, :uuid, :first_name, :last_name, :email, :birth_date, :wine_api_id, :shipping_address, :billing_address, :transactions, :updated_at)
  json.created_at user.created_at.strftime "%m-%d-%Y"
  json.quiz_answers user.quiz_answers do |answer|
    json.question_number answer.question_number
    json.answer_number answer.answer_number
  end
end