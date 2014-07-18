class CreateOrdlns < ActiveRecord::Migration
  def change
    create_table :ordlns do |t|
      t.string :time_created
      t.string :time_modified
      t.string :ref_number
      t.string :duedate
      t.string :expected_drive
      t.string :total_amount
      t.string :is_manually_closed
      t.string :is_fully_received
      t.string :custom_field_authorized_buyer
      t.string :custom_field_status
      t.string :decline
      t.string :decline_rpt
      t.string :decline_date
      t.string :decline_by
      t.string :approve_date
      t.string :approve_by
      t.string :receive_date
      t.string :receive_by
      t.string :vendor_ref_list_id
      t.string :ord_line_qty
      t.string :ord_line_desc
      t.string :ord_line_rate
      t.string :ord_line_amount
      t.string :customer_name

      t.timestamps
    end
  end
end
