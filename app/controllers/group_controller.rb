class GroupController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.users << current_user

    if @group.save
      redirect_to profile_path
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def author_show
    @group_params = params[:groupid]
    @user_params = params[:userid]
    @author_show = User.where("user_id = :user_params and group_id = :group_params", user_params: @user_params, group_params: @group_params)
  end

  private
  def group_params
    params.require(:group).permit(:name)
  end
end
