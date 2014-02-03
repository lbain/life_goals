class Task < ActiveRecord::Base
  belongs_to :goal

  scope :done, -> { where(done: true) }

  before_save :set_goal_done!

  def set_goal_done!
    return unless done and goal.needs_doing?
    goal.done = true
    goal.save
  end

end
