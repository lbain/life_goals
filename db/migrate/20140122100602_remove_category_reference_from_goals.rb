class RemoveCategoryReferenceFromGoals < ActiveRecord::Migration
  def change
      remove_reference :goals, :category
  end
end
