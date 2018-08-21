class SessionsController < ApplicationController
  def new
  end

  def create
    #送信されたメールアドレスをparams[:session][:email]で取得し、そのemailをfind_byメソッドでデータベースからユーザを取り出しています。

    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #ログイン成功した場合
      log_in user  #seesionshelperは,applicationcontrollerに継承されている
      #redirect_to user_url(@user)=(user_path(current_user.id)) と等価であり、@userは、インスタンスでそのuserを表す
      redirect_to user
    else
      #ログイン失敗した場合
      flash.now[:danger] = 'ログインに失敗しました'
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:succeed] = 'ログアウトしました'
    redirect_to root_url
  end
end