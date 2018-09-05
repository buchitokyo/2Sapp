class Like < ApplicationRecord
  #likes_countカラムを親のpicturesテーブルに保存
  belongs_to :picture, counter_cache: :likes_count
  belongs_to :user
end
