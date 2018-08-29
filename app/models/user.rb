class User < ApplicationRecord

  #読み書きできるセッターメゾット
  attr_accessor :remember_token
  mount_uploader :icon, IconUploader

  before_validation { email.downcase! }

  validates :name,  presence: true, length: { maximum: 30 }

  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
   #format: { with: VALID_EMAIL_REGEX }
   #validationされる前にmailを大文字から小文字に変換する

  #セキュアにハッシュ化したパスワードを、データベース内のpassword_digestというカが必要
   has_secure_password
   #allow_nil: trueでパスワードを記入しなくてもupdateできる
   validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
<<<<<<< HEAD

  
=======
   has_many :pictures,dependent: :destroy

>>>>>>> account-activation

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

    update_attribute( :remember_digest, User.digest(remember_token))    #User.digest(string)のやつ
   end

  #渡されたtokenが、ダイジェストと一致したら、trueを返す 記憶トークンと記憶ダイジェストを比較する
   def authenticated?(remember_token)
      #違うブラウザで入った時にエラーを起こすため
      return false if remember_digest.nil?
      #remember_tokenは、attr_accessor :remember_tokenで定義したアクセサとは異なる
      #比較に使っている==演算子が再定義され,is.password?に
      BCrypt::Password.new(remember_digest).is.password?(remember_token)
   end

# ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  # 試作feedの定義
  # 完全な実装は次章の「ユーザーをフォローする」を参照
  #model内で定義
    def feed
      Picture.where("user_id = ?", id)
    end
end
