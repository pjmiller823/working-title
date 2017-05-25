class Group < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships

  has_many :submissions, through: :memberships do
    def upcoming
      where('due_by >= ?', Date.today)
    end
  end

  has_many :invites
end
