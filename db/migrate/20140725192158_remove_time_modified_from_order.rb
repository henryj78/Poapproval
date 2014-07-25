class RemoveTimeModifiedFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :time_modified, :string
    remove_column :orders, :time_created, :string
    remove_column :orders, :duedate, :string
  end
end
