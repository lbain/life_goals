class DateDecorator < Draper::Decorator

  delegate_all

  def day_of_week
    source.strftime('%A')
  end

  def day_classy
    day_of_week.downcase
  end

  def day_month
    source.strftime('%B %d')
  end

end