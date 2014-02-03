class AddDoneToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :done, :boolean, default: false
  end
end
