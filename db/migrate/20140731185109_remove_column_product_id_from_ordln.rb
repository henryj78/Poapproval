class RemoveColumnProductIdFromOrdln < ActiveRecord::Migration
  def change
    remove_column :ordlns, :product_id, :string
  end
end
