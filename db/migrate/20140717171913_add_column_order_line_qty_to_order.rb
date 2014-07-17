class AddColumnOrderLineQtyToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :vendor_ref_list_id, :string
    add_column :orders, :ord_line_qty, :string
    add_column :orders, :ord_line_desc, :string
    add_column :orders, :ord_line_rate, :string
    add_column :orders, :ord_line_amount, :string
  end
end
