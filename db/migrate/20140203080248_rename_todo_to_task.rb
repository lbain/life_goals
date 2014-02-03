class RenameTodoToTask < ActiveRecord::Migration
  def change
    rename_table :todos, :tasks
  end
end
