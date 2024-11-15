class AccessController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    if logged_in?
      redirect_to(root_path)
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      cookies[:user_id] = user.id
      
      logger.info("*** Login User #{params[:email]} ***")
      
      redirect_to root_path, notice: 'User successfully logged in.'
    else
      flash.now[:alert] = 'Invalid email or password.'
      render :new, status: :unauthorized
    end
  end


  def destroy
    logger.info("*** Logout User #{cookies[:user_id]} ***")

    cookies[:user_id] = nil
    session[:user_id] = nil

    redirect_to login_path, notice: 'User successfully logged out.'
  end
end
