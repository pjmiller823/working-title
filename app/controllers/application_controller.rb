class ApplicationController < ActionController::Base
  force_ssl if: :ssl_configured?

  protected

  def ssl_configured?
    Rails.env.production?
  end
  protect_from_forgery with: :exception

  def current_user=(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def logged_in?
    !!current_user
  end
  helper_method :logged_in?

  # Method to use in filter to ensure the user is logged in
  def authenticate!
    unless logged_in?
      redirect_to auth_path(provider: 'github')
    end
  end
end
