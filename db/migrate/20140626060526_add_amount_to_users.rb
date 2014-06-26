class AddAmountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :amount, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :title, :string
  end
end
