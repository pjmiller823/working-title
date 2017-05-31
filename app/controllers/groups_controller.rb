class GroupsController < ApplicationController
  before_action :authenticate!
  before_action :ensure_member!

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
    @submissions = @group.submissions.order(created_at: :desc)
    @invite = Invite.new
    @membership = @group.memberships.find_by(user_id: params[:author_id])
  end

  def author_submissions
    @group = Group.find(params[:id])
    @membership = @group.memberships.find_by(user_id: params[:author_id])
    @user = @membership.user

    @submissions = @membership.submissions.order(created_at: :desc)
    @most_recent_submission = @submissions.first
  end

  private
  def group_params
    params.require(:group).permit(:name)
  end

  def ensure_member!
    group = Group.find(params[:id])

    unless group.users.include?(current_user)
      redirect_to profile_path
    end
  end
end
