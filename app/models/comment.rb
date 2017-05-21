class Comment < ApplicationRecord
  belongs_to :submission
  belongs_to :membership
  belongs_to :user
end
