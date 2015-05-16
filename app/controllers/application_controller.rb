class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def log_in(user)
    session[:session_token] = user.session_token
  end

  def log_out(user)
    current_user.reset_session_token
    session[:session_token] = nil
  end

  def logged_in?
    unless !!current_user
      redirect_to new_session_url
    end
  end
  def current_user
    user = User.find_by(session_token: session[:session_token])
  end
end
