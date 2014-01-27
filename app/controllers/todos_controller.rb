class TodosController < ApplicationController

  before_action :set_todo, only: [:update]

  skip_before_filter :verify_authenticity_token, :only => [:update]

  # GET /todos
  def index
    @todos = Todo.find(:all, :order => "due_date")
  end

  def schedule
    @week = Date.today.at_beginning_of_week..Date.today.at_end_of_week
    @week_todos = Todo.where(due_date: @week).order(:due_date)
    @month_todos = Todo.where(due_date: Date.today.at_end_of_week..5.weeks.from_now).order(:due_date)
    @week = ::DateDecorator.decorate_collection(@week)
    @month_todos = ::TodoDecorator.decorate_collection(@month_todos)
  end

  def update
    @todo.due_date = Date.parse(params[:date])
    @todo.save
    render nothing: true
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

end
