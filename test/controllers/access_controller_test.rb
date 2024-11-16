# frozen_string_literal: true

require 'test_helper'

class AccessControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'should get new' do
    get login_path
    assert_response :success
  end

  test 'should redirect to root if logged in and accessing new' do
    log_in_as(@user)
    get login_path
    assert_redirected_to root_path
  end

  test 'should create session with valid credentials' do
    post login_path, params: { email: @user.email, password: 'password' }
    assert_redirected_to root_path
    assert_equal 'User successfully logged in.', flash[:notice]
    assert_equal @user.id, session[:user_id]
  end

  test 'should not create session with invalid credentials' do
    post login_path, params: { email: @user.email, password: 'wrongpassword' }
    assert_response :unauthorized
    assert_template :new
    assert_nil session[:user_id]
    assert_equal 'Invalid email or password.', flash[:alert]
  end

  test 'should destroy session' do
    log_in_as(@user)
    delete logout_path
    assert_redirected_to login_path
    assert_equal 'User successfully logged out.', flash[:notice]
    assert_nil session[:user_id]
  end
end
