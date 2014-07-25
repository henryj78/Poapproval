class AddColumnDateDueToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :date_due, :string
  end
end
