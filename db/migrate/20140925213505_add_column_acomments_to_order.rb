class AddColumnAcommentsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :acomments, :text
  end
end
