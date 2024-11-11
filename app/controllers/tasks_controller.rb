class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(:position)
  end

  def show
    task_id = params[:id]
    @task = Task.find(task_id)
  end

  def new
    @count = Task.count
    @task = Task.new(position: @count + 1)
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path
    else
      @count = Task.count
      render('new', position: @count + 1)
    end
  end

  def edit
    task_id = params[:id]
    @task = Task.find(task_id)
  end

  def update
    task_id = params[:id]
    @task = Task.find(task_id)

    if @task.update(task_params)
      redirect_to task_path(@task)
    else
      render('edit')
    end
  end

  def delete
    task_id = params[:id]
    @task = Task.find(task_id)
  end

  def destroy
    task_id = params[:id]
    @task = Task.find(task_id)
    @task.destroy
    redirect_to tasks_path
  end

private

  def task_params
    params.require(:task).permit(:name, :description, :position, :category_id, :completed)
  end
end
