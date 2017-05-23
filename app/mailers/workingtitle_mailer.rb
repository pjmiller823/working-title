class WorkingtitleMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def new_user_invite(invite, url)
    @invite = invite
    @url = url
    mail(to: @invite.email, subject: 'You have been invited to Working Title!')
  end

  def submission_to_the_group(submission, group_url)
    @submission = submission
    @users = @submission.group_users
    @group = @submission.group
    @url = group_url

    mail subject: "#{@submission.user_name} has submitted a comment to #{@submission.group_name}",
      to: "notifications@example.com",
      bcc: @users.map(&:email)
  end
end
