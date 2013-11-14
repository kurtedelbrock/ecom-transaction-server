json.array! (@transactions) do |json, transaction|
  json.id transaction.value["transaction_guid"]
  json.product_id transaction.value["product_id"]
  json.timestamp transaction.value["transaction_timestamp"]
  # json.(transaction.value, :transaction_guid, :product_id, :transaction_timestamp)
end