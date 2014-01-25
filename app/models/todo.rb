class Todo < ActiveRecord::Base
  belongs_to :goal


  #TODO: MOVE TO DECORATOR
  def pretty_due_date
    return unless self.due_date.present?
    self.due_date.strftime('%B %d, %Y')
  end
end
