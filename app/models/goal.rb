class Goal < ActiveRecord::Base

  include IceCube

  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :categories


  def self.from_params(params)
    goal = Goal.new
    goal.schedule_from_param(params) if params[:schedule_yaml]
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

  def pretty_categories
    categories.map(&:title).to_sentence
  end
end
