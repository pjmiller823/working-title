class WorkingtitleMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def new_user_invite(invite, url)
    @invite = invite
    @url = url
    mail(to: @invite.email, subject: 'You have been invited to Working Title!')
  end

  def submission_to_the_group(submission, url)
    @submission = submission
    @users = @submission.membership.group.users
    @group = @submission.membership.group
    @url = url

    mail subject: "#{@submission.membership.user.name} has submitted a comment to #{@submission.membership.group.name}",
      to: "notifications@example.com",
      bcc: @users.map(&:email)
  end
end
