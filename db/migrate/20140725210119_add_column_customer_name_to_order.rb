class AddColumnCustomerNameToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :customer_name, :string
    add_column :orders, :project_name, :string
  end
end
