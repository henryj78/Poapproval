class AddColumnDeclineDateToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :decline_date, :string
    add_column :orders, :decline_by, :string
    add_column :orders, :approve_date, :string
    add_column :orders, :approve_by, :string
    add_column :orders, :receive_date, :string
    add_column :orders, :receive_by, :string
  end
end
