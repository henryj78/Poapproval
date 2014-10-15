class AddColumnUnitCostToOrdln < ActiveRecord::Migration
  def change
    add_column :ordlns, :unit_cost, :string
  end
end
