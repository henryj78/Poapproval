class AddColumnCommentsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :user_comments, :string
    add_column :orders, :decliner_comments, :string
  end
end
