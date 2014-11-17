class AddColumnDevicezToOrdln < ActiveRecord::Migration
  def change
    add_column :ordlns, :device, :string
  end
end
