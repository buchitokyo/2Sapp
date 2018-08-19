class Picture < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :content, presence: true
  validates :content, length: { in: 1..50 }
  validates :image, presence: true
end
