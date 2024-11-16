# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks.sorted
    logger.info("TasksController#index - User: #{current_user.id}, Tasks: #{@tasks.map(&:id)}")
  end

  def show
    task_id = params[:id]
    @task = current_user.tasks.find_by(id: task_id)
    if @task
      logger.info("TasksController#show - User: #{current_user.id}, Task: #{@task.id}")
    else
      logger.warn("TasksController#show - User: #{current_user.id}, Task not found: #{task_id}")
      redirect_to tasks_path, alert: 'Task not found'
    end
  end

  def new
    @count = Task.count
    @task = Task.new(position: @count + 1)
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      logger.info("TasksController#create - Task created: #{@task.id}")
      TaskUserAssignment.create(task: @task, user: current_user, role: 'owner')
      redirect_to tasks_path
    else
      logger.error("TasksController#create - Failed to create task: #{task_params}")
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
      logger.info("TasksController#update - Task updated: #{@task.id}")
      redirect_to task_path(@task)
    else
      logger.error("TasksController#update - Failed to update task: #{task_params}")
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
