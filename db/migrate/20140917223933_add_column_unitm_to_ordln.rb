class AddColumnUnitmToOrdln < ActiveRecord::Migration
  def change
    add_column :ordlns, :unitm, :string
  end
end
