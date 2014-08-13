class AddColumnMemoToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :memo, :string
  end
end
