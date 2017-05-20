class UsersController < ApplicationController
  before_action :authenticate!

  def show
    @user = current_user
  end

  private
  def user_params
    params.require(:user).permit(:image)
  end
end
