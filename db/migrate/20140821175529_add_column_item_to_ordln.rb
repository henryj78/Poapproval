class AddColumnItemToOrdln < ActiveRecord::Migration
  def change
    add_column :ordlns, :item, :string
    add_column :ordlns, :mpn, :string
    add_column :ordlns, :wc, :string
    add_column :ordlns, :classz, :string
  end
end
