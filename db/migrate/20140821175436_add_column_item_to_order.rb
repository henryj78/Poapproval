class AddColumnItemToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :item, :string
    add_column :orders, :mpn, :string
    add_column :orders, :wc, :string
    add_column :orders, :classz, :string
  end
end
