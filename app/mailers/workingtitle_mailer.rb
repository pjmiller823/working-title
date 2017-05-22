class WorkingtitleMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def new_user_invite(invite, url)
    @invite = invite
    @url = url
    mail(to: @invite.email, subject: 'You have been invited to Working Title!')
  end
end
