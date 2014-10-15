class AddColumnUnitCostToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :unit_cost, :string
  end
end
