class AddColumnProjectToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :project, :string
    add_column :orders, :sub_approval, :string    
  end
end
