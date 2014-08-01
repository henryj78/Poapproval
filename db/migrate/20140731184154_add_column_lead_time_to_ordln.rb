class AddColumnLeadTimeToOrdln < ActiveRecord::Migration
  def change
    add_column :ordlns, :lead_time, :string
    add_column :ordlns, :product, :string
    add_column :ordlns, :product_id, :string
  end
end
