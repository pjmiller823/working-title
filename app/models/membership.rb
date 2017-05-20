class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :submissions
  has_many :comments, through: :submissions
end
