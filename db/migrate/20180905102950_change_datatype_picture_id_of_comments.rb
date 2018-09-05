class ChangeDatatypePictureIdOfComments < ActiveRecord::Migration[5.1]
  def change
    change_column :comments, :picture_id, :integer
  end
end
