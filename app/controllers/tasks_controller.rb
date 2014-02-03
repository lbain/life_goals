class TasksController < ApplicationController

  before_action :set_task, only: [:update]

  skip_before_filter :verify_authenticity_token, :only => [:update]

  # GET /tasks
  def index
    @tasks = Task.find(:all, :order => "due_date")
  end

  def schedule
    @week = Date.today.at_beginning_of_week..Date.today.at_end_of_week
    @week_tasks = Task.where(due_date: @week).order(:due_date)
    @month_tasks = Task.where(due_date: Date.today.at_end_of_week..5.weeks.from_now).order(:due_date)
    @week = ::DateDecorator.decorate_collection(@week)
    @month_tasks = ::TaskDecorator.decorate_collection(@month_tasks)
  end

  def update
    @task.update(task_params)
    @task.save
    render nothing: true
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).delete_if { |key, value| value == 'null' }
  end

end
