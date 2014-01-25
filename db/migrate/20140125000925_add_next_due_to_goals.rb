class AddNextDueToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :next_due, :datetime
  end
end
