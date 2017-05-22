class User < ApplicationRecord
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :submissions, through: :memberships
  has_many :comments, through: :memberships
  has_many :invitations, class_name: "Invite", foreign_key: 'recipient_id'
  has_many :sent_invites, class_name: "Invite", foreign_key: 'sender_id'

  include ImageUploader[:image]

  def self.from_omniauth(authentication_data)
    user = User.where(provider: authentication_data['provider'],
                      uid: authentication_data['uid']).first_or_create

    Rails.logger.debug "The user is #{user.inspect}"

    user.name         = authentication_data.info.name
    user.nickname     = authentication_data.info.nickname
    user.access_token = authentication_data.info.access_token
    user.email        = authentication_data.info.email

    user.save!

    Rails.logger.debug "After saving, the user is #{user.inspect}"

    return user
  end

end
