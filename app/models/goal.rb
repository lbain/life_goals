class Goal < ActiveRecord::Base

  include IceCube

  belongs_to :category


  def self.from_params(params)
    goal = Goal.new
    goal.schedule_from_param(params)
    params.delete(:schedule_yaml)
    goal.update(params)
    goal
  end

  def schedule_from_param(params)
    rule = RecurringSelect.dirty_hash_to_rule(params[:schedule_yaml])
    schedule = Schedule.new()
    schedule.add_recurrence_rule(rule)
    self.schedule_yaml = schedule.to_yaml
  end

  def schedule
    Schedule.from_yaml(schedule_yaml) if schedule_yaml.present?
  end
end
