# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'should get new' do
    get register_path
    assert_response :success
  end

  test 'should redirect to root if logged in and accessing new' do
    log_in_as(@user)
    get register_path
    assert_redirected_to root_path
  end

  test 'should create user with valid attributes' do
    assert_difference('User.count') do
      post register_path,
           params: { user: { first_name: 'New', last_name: 'User', email: 'new.user@example.com', password: 'password',
                             password_confirmation: 'password' } }
    end
    assert_redirected_to root_path
    assert_equal 'User successfully registered.', flash[:notice]
  end

  test 'should not create user with invalid attributes' do
    assert_no_difference('User.count') do
      post register_path,
           params: { user: { first_name: '', last_name: '', email: 'invalid', password: 'short',
                             password_confirmation: 'mismatch' } }
    end
    assert_response :unprocessable_entity
  end

  test 'should handle failed save' do
    post register_path,
         params: { user: { first_name: '', last_name: '', email: 'invalid', password: 'short',
                           password_confirmation: 'mismatch' } }
    assert_response :unprocessable_entity
  end

  test 'should handle successful save' do
    post register_path,
         params: { user: { first_name: 'New', last_name: 'User', email: 'new.user@example.com', password: 'password',
                           password_confirmation: 'password' } }
    assert_redirected_to root_path
    assert_equal 'User successfully registered.', flash[:notice]
  end
end
