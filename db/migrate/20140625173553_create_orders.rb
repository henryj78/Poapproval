class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
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

      t.timestamps
    end
  end
end
