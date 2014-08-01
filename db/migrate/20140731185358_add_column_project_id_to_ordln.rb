class AddColumnProjectIdToOrdln < ActiveRecord::Migration
  def change
    add_column :ordlns, :project_id, :string
  end
end
