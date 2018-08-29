class Picture < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :content, presence: true
  validates :content, length: { in: 1..70 }
  validates :image, presence: true

  belongs_to :user
  validates :user_id, presence: true
  default_scope -> { order(created_at: :desc) }

  validate  :image_size

  private

    # アップロードされた画像のサイズをバリデーションする
    def image_size
      if image.size > 5.megabytes
        errors.add(:image, "should be less than 50MB")
      end
    end
end
