json.array!(@buyers) do |buyer|
  json.extract! buyer, :id, :phone, :cell, :office
  json.url buyer_url(buyer, format: :json)
end
