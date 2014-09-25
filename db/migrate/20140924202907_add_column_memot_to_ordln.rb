class AddColumnMemotToOrdln < ActiveRecord::Migration
  def change
    add_column :ordlns, :memot, :text
    add_column :ordlns, :ucommentst, :text
  end
end
