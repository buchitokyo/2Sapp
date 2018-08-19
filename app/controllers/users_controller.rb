class UsersController < ApplicationController
  def new
      @user = User.new
  end

    def create
      @user = User.new(user_params)
      if @user.save
        flash[:success] = "Welcome to the WeShred!"
        #これはredirect_to @userというコードから (Railsエンジニアが)
        #user_url(@user)といったコードを実行したいということを、Railsが推察してくれた結果になります。
        redirect_to @user
      else
        render 'new'
      end
    end

    def show
      @user = current_user
      @favorite_pictures = @user.favorite_pictures
    end

    private
    def user_params
      params.require(:user).permit(:name, :email, :password,:password_confirmation, :icon, :icon_cache)
    end
end
