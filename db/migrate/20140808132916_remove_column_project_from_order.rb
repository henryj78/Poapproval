class RemoveColumnProjectFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :project, :string
  end
end
