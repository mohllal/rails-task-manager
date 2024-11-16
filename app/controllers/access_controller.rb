# frozen_string_literal: true

# AccessController manages the user login and logout process.
class AccessController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]

  def new
    return unless logged_in?

    redirect_to(root_path)
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      login_user(user)
    else
      handle_failed_login
    end
  end

  def destroy
    logger.info("AccessController#destroy - Logout user: #{cookies[:user_id]}")

    cookies[:user_id] = nil
    session[:user_id] = nil

    redirect_to login_path, notice: 'User successfully logged out.'
  end

  private

  def login_user(user)
    session[:user_id] = user.id
    cookies[:user_id] = user.id

    logger.info("AccessController#create - Login user: #{params[:email]}")

    redirect_to root_path, notice: 'User successfully logged in.'
  end

  def handle_failed_login
    logger.error("AccessController#create - Failed to login user: #{params[:email]}")
    flash.now[:alert] = 'Invalid email or password.'
    render :new, status: :unauthorized
  end
end
