# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    if logged_in?
      redirect_to(root_path)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      cookies[:user_id] = @user.id
      logger.info("UsersController#create - User created: #{user_params}")
      redirect_to root_path, notice: 'User successfully registered.'
    else
      logger.error("UsersController#create - Failed to create user: #{user_params}")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end
