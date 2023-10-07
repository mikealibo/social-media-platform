class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :content, presence: true

  def total_comments_to_display
    comments.limit(Comment::TOTAL_COMMENTS_TO_DISPLAY)
  end
end
