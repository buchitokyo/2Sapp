class AddLikesCountToPictures < ActiveRecord::Migration[5.1]
  def change
    add_column :pictures, :likes_count, :integer
  end
end
