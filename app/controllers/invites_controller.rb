class InvitesController < ApplicationController
  before_action :authenticate!, except: [:accept]

  def create
    @invite = Invite.new(invite_params) # Make a new Invite
    @invite.sender = current_user # set the sender to the current user

    if @invite.save
      WorkingtitleMailer.new_user_invite(@invite, accept_invite_url(token: @invite.token)).deliver # send the invite data to our mailer to deliver the email
    else
      # oh no, creating an new invitation failed
    end
  end

  def accept
    @invite = Invite.find_by(token: params[:token])
  end
end
