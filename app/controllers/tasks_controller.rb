class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks.sorted
  end

  def show
    task_id = params[:id]
    @task = current_user.tasks.find_by(id: task_id)
    redirect_to tasks_path, alert: 'Task not found' unless @task
  end

  def new
    @count = Task.count
    @task = Task.new(position: @count + 1)
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      TaskUserAssignment.create(task: @task, user: current_user, role: "owner")
      redirect_to tasks_path
    else
      @count = Task.count
      render 'new', status: :unprocessable_entity
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
