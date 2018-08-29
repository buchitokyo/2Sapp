class ChangeDatatypeUserIdOfPictures < ActiveRecord::Migration[5.1]
  def change
    change_column :pictures, :user_id, :integer
  end
end
