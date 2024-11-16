# frozen_string_literal: true

# UsersController manages the user registration process.
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
      handle_successful_save
    else
      handle_failed_save
    end
  end

  private

  def handle_successful_save
    session[:user_id] = @user.id
    cookies[:user_id] = @user.id
    logger.info("UsersController#create - User created: #{user_params}")
    redirect_to root_path, notice: 'User successfully registered.'
  end

  def handle_failed_save
    logger.error("UsersController#create - Failed to create user: #{user_params}")
    render :new, status: :unprocessable_entity
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end
