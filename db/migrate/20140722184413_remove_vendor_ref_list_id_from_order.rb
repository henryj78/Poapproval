class RemoveVendorRefListIdFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :vendor_ref_list_id, :string
    remove_column :orders, :expected_drive, :string
    remove_column :orders, :ord_line_qty, :string
    remove_column :orders, :ord_line_desc, :string    
    remove_column :orders, :ord_line_rate, :string 
    remove_column :orders, :ord_line_amount, :string                   
  end
end
