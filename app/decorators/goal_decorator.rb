class GoalDecorator < Draper::Decorator

  def due_date
    return unless source.due_date.present?
    source.due_date.strftime(due_date_strf)
  end

  def title
    goal.title
  end

  def due_date
    return unless source.due_date.present?
    source.due_date.strftime('%B %d, %Y')
  end

  def categories
    source.categories.map(&:title).to_sentence
  end

  def main_category
    source.categories.first.title if source.categories.any?
  end

  def schedule
    source.schedule.to_s
  end

  def next_due
    return unless source.next_due.present?
    source.next_due.strftime('%B %d, %Y')
  end

  private

  def due_date_strf
    case source.precision
    when 'year'
      '%Y'
    when 'month'
      '%B %Y'
    when 'day'
      '%B %d, %Y'
    end
  end

end