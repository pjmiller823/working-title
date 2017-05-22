# Preview all emails at http://localhost:3000/rails/mailers/workingtitle_mailer
class WorkingtitleMailerPreview < ActionMailer::Preview
  def new_user_invite
    @invite = Invite.new
    WorkingtitleMailer.new_user_invite(@invite, "wwww.google.com")
  end
end
