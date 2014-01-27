class TodoDecorator < Draper::Decorator

  decorates_association :goal

  delegate :id

  def title
    goal.title
  end

  def due_date
    return unless source.due_date.present?
    source.due_date.strftime('%B %d, %Y')
  end

  def categories
    goal.categories
  end

  def category_classy
    goal.main_category.downcase if goal.main_category
  end

end