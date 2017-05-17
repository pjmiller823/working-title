class SessionController < ApplicationController
  layout false

  # logging in
  def new
  end

  # handle the post from the login page
  def create
    self.current_user = User.from_omniauth(request.env['omniauth.auth'])

    if current_user
      redirect_to profile_path
    else
      redirect_to auth_path(provider: 'github')
    end
  end

  # logout
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  # Show the failure page
  def failure
    redirect_to root_path
  end
end
