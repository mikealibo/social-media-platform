class Comment < ApplicationRecord
  TOTAL_COMMENTS_TO_DISPLAY = 3
  belongs_to :user
  belongs_to :post
  
  validates :content, presence: true
end
