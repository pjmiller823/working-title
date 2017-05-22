class InvitesController < ApplicationController
  before_create :generate_token

  def generate_token
    self.token = Digest::SHA1.hexdigest([self.group_id, Time.now, rand].join)
  end

  def create
    @invite = Invite.new(invite_params) # Make a new Invite
    @invite.sender_id = current_user.id # set the sender to the current user
    if @invite.save
      WorkingtitleMailer.new_user_invite(@invite, login_path(invite_token: @invite.token)).deliver # send the invite data to our mailer to deliver the email
    else
      # oh no, creating an new invitation failed
    end
  end
end
