class AddColumnVendorNameToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :vendor_name, :string
  end
end
