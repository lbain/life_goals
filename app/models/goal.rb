class Goal < ActiveRecord::Base

  include IceCube

  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :categories


  def self.from_params(params)
    goal = Goal.new
    goal.schedule_from_param(params) if params[:schedule_yaml]
    params.delete(:schedule_yaml)
    goal.set_precision(params)
    params = format_due_date_params(params)
    goal.update(params)
    goal.generate_todos
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

  def generate_todos
    self.schedule.present? ? generate_todos_from_schedule : generate_todos_from_due_date
  end

  def schedule
    Schedule.from_yaml(schedule_yaml) if schedule_yaml.present?
  end

  ### TODO: MOVE TO DECORATOR

  def pretty_categories
    categories.map(&:title).to_sentence
  end

  def due_date_strf
    case self.precision
    when 'year'
      '%Y'
    when 'month'
      '%B %Y'
    when 'day'
      '%B %d, %Y'
    end
  end

  def pretty_due_date
    return unless self.due_date.present?
    self.due_date.strftime(due_date_strf)
  end

  private

  def generate_todos_from_schedule
    now = Time.now
    schedule.send(:enumerate_occurrences, now, now + 4.weeks).each do |todo_date|
      todo = Todo.new
      todo.due_date = todo_date.to_datetime
      todo.goal_id = self.id
      todo.save
    end
  end

  def generate_todos_from_due_date
    todo = Todo.new
    todo.due_date = self.due_date
    todo.goal = self
    todo.save
  end

end
