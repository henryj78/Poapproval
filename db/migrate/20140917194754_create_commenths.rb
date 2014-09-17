class CreateCommenths < ActiveRecord::Migration
  def change
    create_table :commenths do |t|
      t.string :ref_number
      t.string :comment

      t.timestamps
    end
  end
end
