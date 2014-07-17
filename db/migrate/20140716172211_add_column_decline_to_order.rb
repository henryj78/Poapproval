class AddColumnDeclineToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :decline, :string
  end
end
