class GroupsController < ApplicationController
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
    @authors = @group.users
  end

  def author_submissions
    @group = Group.find(params[:id])
    @user = @group.users.find(params[:author_id])
  end

  private
  def group_params
    params.require(:group).permit(:name)
  end
end
