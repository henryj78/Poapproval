class AddColumnKanbanToOrdln < ActiveRecord::Migration
  def change
    add_column :ordlns, :kanban, :string
  end
end
