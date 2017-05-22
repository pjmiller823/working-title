class Invite < ApplicationRecord
  belongs_to :group
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  validates :token, uniqueness: true

  before_create :generate_token

  def accept(user)
    # Join this current_user to the group specified in the token
    user.groups << group

    # Zap that invite so it can't be used again
    destroy
  end

  private

  def generate_token
    self.token = SecureRandom.hex(20)
  end
end
