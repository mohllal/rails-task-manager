# frozen_string_literal: true

require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:one)
    @user = users(:one)
    log_in_as(@user)
  end

  test 'should get index' do
    get tasks_path
    assert_response :success
  end

  test 'should get show' do
    get task_path(@task)
    assert_response :success
  end

  test 'should get new' do
    get new_task_path
    assert_response :success
  end

  test 'should get edit' do
    get edit_task_path(@task)
    assert_response :success
  end

  test 'should get delete' do
    get delete_task_path(@task)
    assert_response :success
  end

  test 'should create task' do
    assert_difference('Task.count') do
      post tasks_path,
           params: { task: { name: 'New Task', description: 'Task description', position: 1 } }
    end
    assert_redirected_to tasks_path

    # Ensure the TaskUserAssignment is created
    task = Task.last
    assert task.users.include?(@user)
  end

  test 'should delete task' do
    assert_difference('Task.count', -1) do
      delete task_path(@task)
    end
    assert_redirected_to tasks_path
  end
end
