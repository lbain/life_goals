class Repeat
  include ActiveModel::Validations #todo - add validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  include IceCube

  attr_accessor :weeks
  attr_accessor :days_of_week

  attr_accessor :months
  attr_accessor :date_of_month
  attr_accessor :months_of_year

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def to_rule
    rule = Rule
    if weeks.present?
      rule = rule.weekly(weeks)
    end
    rule
  end

  def persisted?
    false
  end
end