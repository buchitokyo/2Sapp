class Picture < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :content, presence: true
  validates :content, length: { in: 1..70 }
  validates :image, presence: true

  belongs_to :user
  #いいね機能
  has_many :likes, dependent: :destroy
  #has_many :like_users, through: :likes, source: :user

#引数で入ったuser_idをlike定義
# ライクしているユーザーかどうか
  def like_user?(user_id)
   likes.find_by(user_id: user_id)
  end

  validates :user_id, presence: true
  default_scope -> { order(created_at: :desc) }

  validate  :image_size

  has_many :comments, dependent: :destroy
  #has_many :comments_picture, through: :comments, source: :use

  scope :search_by_keyword, -> (keyword) {
    where("pictures.content LIKE :keyword", keyword: "%#{sanitize_sql_like(keyword)}%") if keyword.present?}

  private

    # アップロードされた画像のサイズをバリデーションする
    def image_size
      if image.size > 5.megabytes
        errors.add(:image, "should be less than 50MB")
      end
    end
end
