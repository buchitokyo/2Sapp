class User < ApplicationRecord
 before_validation { email.downcase! }

 validates :name,  presence: true, length: { maximum: 30 }

 #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
 validates :email, presence: true, length: { maximum: 255 },
 format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
 #format: { with: VALID_EMAIL_REGEX }
 #validationされる前にmailを大文字から小文字に変換する

#セキュアにハッシュ化したパスワードを、データベース内のpassword_digestというカが必要
 has_secure_password
 validates :password, presence: true, length: { minimum: 6 }
end
