class AddColumnDeviceToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :device, :string
  end
end
