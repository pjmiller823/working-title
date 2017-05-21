class Comment < ApplicationRecord
  belongs_to :submission
  belongs_to :created_by, class_name: "User"
end
