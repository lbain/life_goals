class TodosController < ApplicationController

  # GET /todos
  def index
    @todos = Todo.find(:all, :order => "due_date")
  end

  def schedule
    @week = Date.today.at_beginning_of_week..Date.today.at_end_of_week
    @week_todos = Todo.where(due_date: @week).order(:due_date)
    @month_todos = Todo.where(due_date: Date.today.at_end_of_week..5.weeks.from_now).order(:due_date)
    @week = ::DateDecorator.decorate_collection(@week)
  end

end
