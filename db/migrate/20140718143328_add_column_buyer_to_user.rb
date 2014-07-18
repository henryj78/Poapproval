class AddColumnBuyerToUser < ActiveRecord::Migration
  def change
    add_column :users, :buyer, :string
  end
end
