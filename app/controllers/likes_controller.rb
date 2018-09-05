class LikesController < ApplicationController
  
  def create
    # pictureを取得します。（before_actionをしっていたら共通化しましょう）
    #@picture = Picture.find(params[:picture_id])
    @like = Like.create(user_id: current_user.id, picture_id: params[:picture_id])

    # 以下は多分必要ないので削除
    #whereでデータ取得
    @likes = Like.where(picture_id: params[:picture_id])
    #@pictures = Picture.all

  end

  def destroy
    # pictureを取得します。（before_actionをしっていたら共通化しましょう）
    #@picture = Picture.find(params[:picture_id])
    like = Like.find_by(user_id: current_user.id, picture_id: params[:picture_id])
    like.destroy

    # 以下は多分必要ないので削除
    #@likes = Like.where(picture_id: params[:picture_id])
    #@pictures = Picture.all
  end

end
