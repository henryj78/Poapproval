class AddColumnMemoToOrdln < ActiveRecord::Migration
  def change
    add_column :ordlns, :memo, :string
  end
end
