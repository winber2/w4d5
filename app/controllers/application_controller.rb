class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login!(user)
    @current_user = user
    session[:session_token] = user.session_token
  end

  def logout!(user)
    user.reset_session_token!
    @current_user = nil
    session[:session_token] = nil
  end

end
