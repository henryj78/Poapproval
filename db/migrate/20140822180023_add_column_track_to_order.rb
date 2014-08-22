class AddColumnTrackToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :track, :string
    add_column :orders, :po_status, :string
  end
end
