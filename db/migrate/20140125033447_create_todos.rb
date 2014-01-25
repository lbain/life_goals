class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.belongs_to :goal
      t.boolean :done, default: false
      t.string :due_date
      t.string :datetime

      t.timestamps
    end
  end
end
