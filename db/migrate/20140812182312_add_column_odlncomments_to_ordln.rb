class AddColumnOdlncommentsToOrdln < ActiveRecord::Migration
  def change
    add_column :ordlns, :user_comments, :string
    add_column :ordlns, :decliner_comments, :string
  end
end
