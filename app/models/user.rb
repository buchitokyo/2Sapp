class User < ApplicationRecord
  #読み書きできるセッターメゾット
 attr_accessor :remember_token


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

#ハッシュ値を返すコストの少ない方法で
  def User.digest(string)
     cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                   BCrypt::Engine.cost
     BCrypt::Password.create(string, cost: cost)
  end

# ランダムなトークンを返す  文字 (64種類)
 def User.new_token
  SecureRandom.urlsafe_base64
 end

# 永続セッションのためにユーザーをデータベースに記憶する
 def remember
  # メゾット内でセッターメゾットを呼び出す場合は、selfを必ずつける。
  # 使用しないとremember_tokenという名前のローカル変数が作成されてしまう。
  # user.remember_tokenメソッド (cookiesの保存場所です) を使ってトークンにアクセスできるようにする必要
  self.remember_token = User.new_token
  #update_attributeメソッドを使って記憶ダイジェストを更新と保存を同時に行う。
  update_attribute( :remember_digest, User.digest(remember_token))
 end

end
