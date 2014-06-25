json.array!(@orders) do |order|
  json.extract! order, :id, :time_created, :time_modified, :ref_number, :duedate, :expected_drive, :total_amount, :is_manually_closed, :is_fully_received, :custom_field_authorized_buyer, :custom_field_status
  json.url order_url(order, format: :json)
end
