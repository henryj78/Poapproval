class AddColumnTermsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :terms, :string
    add_column :orders, :address, :string
    add_column :orders, :city, :string
  end
end
