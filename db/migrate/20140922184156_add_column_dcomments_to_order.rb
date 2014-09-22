class AddColumnDcommentsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :dcomments, :text
  end
end
