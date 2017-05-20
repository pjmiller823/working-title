class Comment < ApplicationRecord
  belongs_to :submission
  belongs_to :membership, through: :submission
end
