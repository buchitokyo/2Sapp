class ChangeDatatypeUserIdOfComments < ActiveRecord::Migration[5.1]
  def change
    change_column :comments, :user_id, :integer
  end
end
