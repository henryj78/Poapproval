class AddColumnExpectedDateToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :expected_date, :string
  end
end
