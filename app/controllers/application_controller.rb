class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include PicturesHelper
  # beforeアクション
  # ログイン済みユーザーかどうか確認  picture_controllerでも必要なため
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインして下さい"
        #この場合、unlessは、偽であれば処理する またリダイレクトでは、url形式で書く
        redirect_to login_url
      end
    end
end
