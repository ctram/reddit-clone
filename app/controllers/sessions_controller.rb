class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    username = params[:user][:username]
    password = params[:user][:password]
    @user = User.find_by_credentials(username, password)
    if @user.nil?
      flash.now[:errors] = ['Incorrect password or username combination']
      render :new
    else
      log_in(@user)
      redirect_to user_url(@user)
    end
  end

  def destroy
    log_out(current_user)
    redirect_to users_url
  end
end
