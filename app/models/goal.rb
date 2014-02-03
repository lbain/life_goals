class Goal < ActiveRecord::Base

  include IceCube

  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :categories

  has_many :tasks


  def self.from_params(params)
    goal = Goal.new
    goal.schedule_from_param(params) if params[:schedule_yaml]
    params.delete(:schedule_yaml)
    goal.set_precision(params)
    params = format_due_date_params(params)
    goal.update(params)
    goal.generate_tasks
    goal
  end

  def set_precision(params)
    date = {"year" => params["due_date(1i)"],
            "month" => params["due_date(2i)"],
            "day" => params["due_date(3i)"] }
    date.each do |key, value|
      self.precision = key if value.present?
    end
  end

  def self.format_due_date_params(params)
    [2,3].each do |num|
      params["due_date(#{num}i)"] = '1' if params["due_date(#{num}i)"].empty?
    end
    params
  end

  def schedule_from_param(params)
    rule = RecurringSelect.dirty_hash_to_rule(params[:schedule_yaml])
    schedule = Schedule.new()
    schedule.add_recurrence_rule(rule)
    self.schedule_yaml = schedule.to_yaml
    self.set_next_due!
  end

  def set_next_due!
    if self.schedule.first.today?
      self.next_due = self.schedule.first(2).last
    else
      self.next_due = self.schedule.first
    end
  end

  def generate_tasks
    self.schedule.present? ? generate_tasks_from_schedule : generate_tasks_from_due_date
  end

  def done_tasks
    tasks.done
  end

  def needs_doing?
    due_date.present? and not done
  end

  def schedule
    Schedule.from_yaml(schedule_yaml) if schedule_yaml.present?
  end

  private

  def generate_tasks_from_schedule
    now = Time.now
    schedule.send(:enumerate_occurrences, now, now + 4.weeks).each do |task_date|
      task = Task.new
      task.due_date = task_date.to_datetime
      task.goal_id = self.id
      task.save
    end
  end

  def generate_tasks_from_due_date
    task = Task.new
    task.due_date = self.due_date
    task.goal = self
    task.save
  end

end
