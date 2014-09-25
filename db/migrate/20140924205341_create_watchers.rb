class CreateWatchers < ActiveRecord::Migration
  def change
    create_table :watchers do |t|
      t.string :po
      t.string :project
      t.string :customer
      t.string :approver
      t.string :task

      t.timestamps
    end
  end
end
