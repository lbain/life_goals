class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title
      t.datetime :due_date
      t.string :schedule_yaml

      t.timestamps
    end
  end
end
