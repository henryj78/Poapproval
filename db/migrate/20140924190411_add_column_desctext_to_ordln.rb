class AddColumnDesctextToOrdln < ActiveRecord::Migration
  def change
    add_column :ordlns, :desctext, :text
  end
end
