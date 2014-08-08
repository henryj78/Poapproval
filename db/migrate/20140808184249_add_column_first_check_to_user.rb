class AddColumnFirstCheckToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_check, :string
  end
end
