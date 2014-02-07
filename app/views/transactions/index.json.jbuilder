json.array! (@transactions) do |json, transaction|
  json.id transaction.value["transaction_guid"]
  json.product_id transaction.value["product_id"]
  json.timestamp transaction.value["transaction_timestamp"]
  json.first_name transaction.value["first_name"]
  json.last_name transaction.value["last_name"]
  # json.(transaction.value, :transaction_guid, :product_id, :transaction_timestamp)
end