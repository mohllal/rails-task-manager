# frozen_string_literal: true

require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'should redirect to login if not logged in' do
    get root_path
    assert_redirected_to login_path
  end

  test 'should get index if logged in' do
    log_in_as(@user)
    get root_path
    assert_response :success
  end
end
