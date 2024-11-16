# frozen_string_literal: true

require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:one)
    @user = users(:one)
    log_in_as(@user)
  end

  test 'should get index' do
    get categories_path
    assert_response :success
  end

  test 'should get show' do
    get category_path(@category)
    assert_response :success
  end

  test 'should get new' do
    get new_category_path
    assert_response :success
  end

  test 'should get edit' do
    get edit_category_path(@category)
    assert_response :success
  end

  test 'should get delete' do
    get delete_category_path(@category)
    assert_response :success
  end

  test 'should create category' do
    assert_difference('Category.count') do
      post categories_path, params: { category: { name: 'New Category', user_id: @user.id } }
    end
    assert_redirected_to categories_path
  end

  test 'should delete category' do
    assert_difference('Category.count', -1) do
      delete category_path(@category)
    end
    assert_redirected_to categories_path
  end
end
