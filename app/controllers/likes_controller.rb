class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @picture = Picture.find(params[:picture_id])
    @like = @picture.likes.create(user_id: current_user.id, picture_id: params[:picture_id])
    @likes = Like.where(picture_id: params[:picture_id])
    @pictures = Picture.all
  end

  def destroy
    #テーブルの構成
    like = Like.find_by(user_id: current_user.id, picture_id: params[:picture_id])
    like.destroy
    @likes = Like.where(picture_id: params[:picture_id])
    @pictures = Picture.all
  end

end
