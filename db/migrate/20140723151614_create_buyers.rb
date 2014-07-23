class CreateBuyers < ActiveRecord::Migration
  def change
    create_table :buyers do |t|
      t.string :phone
      t.string :cell
      t.string :office

      t.timestamps
    end
  end
end
