class AddColumnCusNameToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :customer_name, :string
  end
end
