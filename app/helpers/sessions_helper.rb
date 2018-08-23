module SessionsHelper
  # 渡されたユーザーでログインする
 def log_in(user)
 #これはuserのidを付与しているとみられる。
 #ユーザーのブラウザ内のcookiesに暗号化されたユーザーIDが自動で生成されます。
   session[:user_id] = user.id
 end

  # ユーザーのセッションを永続的にする
  def remember(user)
    #rememberメソッド定義のuser.rememberを呼び出すまで遅延され、
    #そこで記憶トークンを生成してトークンのダイジェストをデータベースに保存します。
    user.remember
    #cookiesメソッドでユーザーIDと記憶トークンの永続cookiesを作成します。
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 渡されたユーザーがログイン済みユーザーであればtrueを返す
  def current_user?(user)
    user == current_user
  end

  # 現在ログイン中のユーザーを返す (いる場合)
  # 記憶トークンcookieに対応するユーザーを返す
 def current_user
  if ( user_id = session[ :user_id ])
    @current_user ||= User.find_by(id: session[:user_id])
  elsif ( user_id = cookies.signed[:user_id])
    user  = user.find_by(id: user_id)
    if user && user.authenticated?(cookies[:remember_token])
      log_in user
      @current_user = user
    end
  end
 end

  def logged_in?
    current_user.present?
  end

  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # 記憶したURL (もしくはデフォルト値) にリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)  #[:return_to]も可
    session.delete(:forwarding_url)
  end

  # アクセスしようとしたURLを覚えておく
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

end
