class InvitesController < ApplicationController
  before_action :authenticate!, except: [:accept]

  def create
    @invite = Invite.new(invite_params) # Make a new Invite
    @invite.sender = current_user # set the sender to the current user

    if @invite.save
      WorkingtitleMailer.new_user_invite(@invite, accept_invites_url(token: @invite.token)).deliver # send the invite data to our mailer to deliver the email
      redirect_to @invite.group, notice: "Sent the email to #{@invite.email}"
    else
      # oh no, creating an new invitation failed
      redirect_to @invite.group, notice: "Failed to send email to #{@invite.email}, because: #{@invite.errors.full_messages}"
    end
  end

  def accept
    @invite = Invite.find_by(token: params[:token])
  end

  private
  def invite_params
    params.require(:invite).permit(:email, :group_id)
  end
end
