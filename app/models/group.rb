class Group < ApplicationRecord
  has_many :user, through: :memberships
  has_many :memberships
end
