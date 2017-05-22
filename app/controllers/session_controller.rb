class SessionController < ApplicationController
  layout false

  # logging in
  def new
  end

  # handle the post from the login page
  def create
    self.current_user = User.from_omniauth(request.env['omniauth.auth'])

    if current_user
      omniauth_params = request.env["omniauth.params"]

      # if there is an invite token
      if omniauth_params && omniauth_params["workingtitle_invite_token"]
        token = omniauth_params["workingtitle_invite_token"]

        # Fetch the invite from the token
        invite = Invite.find_by(token: token)

        invite.accept(current_user)
      end

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
