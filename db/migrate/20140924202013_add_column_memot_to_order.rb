class AddColumnMemotToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :memot, :text
    add_column :orders, :ucommentst, :text
  end
end
