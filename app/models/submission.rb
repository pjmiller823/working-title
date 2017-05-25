class Submission < ApplicationRecord
  validates :body, presence: true
  validates :title, presence: true

  belongs_to :membership
  has_many :comments

  scope :upcoming, -> { where('due_by >= ?', Date.today) }

  delegate :user, to: :membership
  delegate :name, to: :user, prefix: true
  delegate :email, to: :user, prefix: true

  delegate :group, to: :membership
  delegate :name, :users, to: :group, prefix: true
end
