# frozen_string_literal: true

# ApplicationController is the base controller for all other controllers.
# It provides common functionality such as user authentication and helper methods.
class ApplicationController < ActionController::Base
  before_action :current_user
  before_action :authenticate_user!

  helper_method :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def authenticate_user!
    redirect_to login_path unless current_user
  end
end
