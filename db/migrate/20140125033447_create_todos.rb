class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.belongs_to :goal
      t.boolean :done, default: false
      t.datetime :due_date

      t.timestamps
    end
  end
end
