class TasksController < ApplicationController
  respond_to :html, :json
  expose_parent :document, [:proposal, :experiencie, :category]
  expose(:tasks) { document.tasks }
  expose(:task)

  def new
  end

  def show
    task = Task.find params[:id]
    redirect_to [task.document, :edition]
  end

  def create
    authorize! :create, task
    task.save
    respond_with task, location: [document, :edition]
  end

  def update
    authorize! :update, task
    task.finished = !task.finished
    task.save
    respond_with task, location: [document, :edition]
  end
end
