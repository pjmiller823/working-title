class Group < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships
  has_many :submissions, through: :memberships
  has_many :invites
end
