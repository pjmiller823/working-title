class WorkingtitleMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def new_user_invite(invite, url)
    @invite = invite
    @url = url
  end
end
