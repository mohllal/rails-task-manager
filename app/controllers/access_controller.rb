class AccessController < ApplicationController
  skip_before_action :confirm_logged_in, only: [:new, :create]

  def new
    if logged_in?
      redirect_to(root_path)
    end
  end

  def create
    logger.info("*** Login User #{params[:username]} ***")

    logger.info("Username: #{params[:username]}")
    cookies[:username] = params[:username]
    session[:user_id] = 1483

    flash[:notice] = "Log in successful"
    redirect_to(root_path)
  end


  def destroy
    logger.info("*** Logout User #{cookies[:username]} ***")

    cookies[:username] = nil
    session[:user_id] = nil

    flash[:notice] = "Logged out"
    redirect_to(login_path)
  end
end
