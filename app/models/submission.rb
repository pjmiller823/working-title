class Submission < ApplicationRecord
  belongs_to :membership
  has_many :comments

  delegate :user, to: :membership
  delegate :name, to: :user, prefix: true
  delegate :email, to: :user, prefix: true

  delegate :group, to: :membership
  delegate :name, :users, to: :group, prefix: true
end
