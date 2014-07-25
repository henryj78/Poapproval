class AddColumnDeviceToOrdln < ActiveRecord::Migration
  def change
    add_column :ordlns, :device, :string
    add_column :ordlns, :assemblies, :string
  end
end
