class AddPrecisionToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :precision, :string
  end
end
