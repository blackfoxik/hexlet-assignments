# frozen_string_literal: true

require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  setup do
    @attributes = {
      name: Faker::Name.name,
      description: 'desc',
      status: 'new',
      creator: Faker::Name.name,
      performer: Faker::Name.name,
      completed: false
    }
  end

  test 'success index' do
    get root_path
    assert_response :success
  end

  test 'success read' do
    task = tasks(:one)
    get task_path(task)
    assert_response :success
  end

  test 'success create' do
    post tasks_path(params: { task: @attributes })
    task = Task.find_by! name: @attributes[:name]

    assert_redirected_to task_url(task)
  end

  test 'delete' do
    task = tasks(:one)
    delete task_url(task)

    assert_redirected_to tasks_url

    assert { !Task.exists? task.id }
  end

  test 'update ' do
    task = tasks(:one)
    patch task_url(task), params: { task: @attributes }
    assert_redirected_to task_url(task)

    task.reload

    assert { task.name == @attributes[:name] }
  end
end
