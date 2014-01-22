class AddCategoriesGoals < ActiveRecord::Migration
  def change
    create_table :categories_goals, :id => false do |t|
      t.integer :category_id
      t.integer :goal_id
    end
  end
end
