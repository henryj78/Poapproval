class AddColumnDatedueToOrdln < ActiveRecord::Migration
  def change
    add_column :ordlns, :date_due, :string
    add_column :ordlns, :expected_date, :string
    add_column :ordlns, :terms, :string
    add_column :ordlns, :address, :string
    add_column :ordlns, :city, :string
  end
end
