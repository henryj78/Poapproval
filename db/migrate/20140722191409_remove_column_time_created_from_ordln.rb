class RemoveColumnTimeCreatedFromOrdln < ActiveRecord::Migration
  def change
    remove_column :ordlns, :time_created, :string
    remove_column :ordlns, :time_modified, :string
    remove_column :ordlns, :duedate, :string
    remove_column :ordlns, :expected_drive, :string
    remove_column :ordlns, :total_amount, :string
    remove_column :ordlns, :is_manually_closed, :string
    remove_column :ordlns, :vendor_ref_list, :string
  end
end
