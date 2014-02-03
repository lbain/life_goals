class Task < ActiveRecord::Base
  belongs_to :goal

  scope :done, -> { where(done: true) }


end
