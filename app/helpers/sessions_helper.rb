module SessionsHelper
  # 渡されたユーザーでログインする
 def log_in(user)
 #これはuserのidを付与しているとみられる。
 #ユーザーのブラウザ内のcookiesに暗号化されたユーザーIDが自動で生成されます。
   session[:user_id] = user.id
 end

 # 現在ログイン中のユーザーを返す (いる場合)
 def current_user
   @current_user ||= User.find_by(id: session[:user_id])
 end

  def logged_in?
    current_user.present?
  end

  # 現在のユーザーをログアウトする
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
