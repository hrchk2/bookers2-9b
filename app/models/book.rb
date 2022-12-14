class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  scope :created_days_ago, ->(n) { where(created_at: n.days.ago.all_day) }

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.past_week_count
 (0..6).map { |n| created_days_ago(n).count }.reverse
  end

end
