class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index,:edit,:update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    #:page パラメーターに基づいて、DBからデータをとる
    @users = User.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save

      UserMailer.user_mail(@user).deliver
      flash[:success] = "Welcome to the WeShred!"
      #これはredirect_to @userというコードから (Railsエンジニアが)
      #user_url(@user)といったコードを実行したいということを、Railsが推察してくれた結果になります。
      redirect_to @user
    else
      render 'new'
    end
  end

    def show
      @user = User.find(params[:id])
      @pictures = @user.pictures.page(params[:page])
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if  @user.update_attributes(user_params)
        # 更新に成功した場合を扱う。
        flash[:success] = "Profile updated"
        redirect_to @user  #users#show
      else
        render 'edit'
      end
    end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

    private
    def user_params
      params.require(:user).permit(:name, :email, :password,:password_confirmation, :icon, :icon_cache)
    end

   # beforeフィルター

    # 正しいユーザーかどうか確認
    def correct_user
    @user = User.find(params[:id])
    #sessionhelperで定義   @user == correct_userも可
    redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
