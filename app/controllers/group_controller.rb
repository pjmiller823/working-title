class GroupController < ApplicationController
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
  end

  private
  def group_params
    params.require(:group).permit(:name)
  end
end
