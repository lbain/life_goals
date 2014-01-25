class TodosController < ApplicationController

  # GET /todos
  def index
    @todos = Todo.find(:all, :order => "due_date")
  end

end
