class StaticPagesController < ApplicationController

  def home
    if logged_in?
      #インスタンス変数もログインしているときのみ定義されるようになる
      @picture = current_user.pictures.build
      #外部からメゾットを呼び出せる feedも上もそうだが、モデルでアソシエーションを組んでるから使える
      @feed_items = current_user.feed.page(params[:page])
      @comment = Comment.new
      @comments = @picture.comments
      @likes = Like.where(picture_id: params[:picture_id])
    end
  end

  def about
  end

  private

  def picture_params
    params.require(:picture).permit(:image,:image_cache,:content)
  end
end
