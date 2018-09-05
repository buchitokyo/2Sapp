class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :picture
      t.text :content
      t.references :user

      t.timestamps
    end
  end
end
