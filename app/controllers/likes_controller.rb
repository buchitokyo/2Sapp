class LikesController < ApplicationController

  def create
    @like = Like.create(user_id: current_user.id, picture_id: params[:picture_id])
    @likes = Like.where(picture_id: params[:picture_id])
    @picture = Picture.find(params[:picture_id])
    respond_to do |format|
        format.html
        format.js
    end
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, picture_id: params[:picture_id])
    like.destroy
    @likes = Like.where(picture_id: params[:picture_id])
    @picture = Picture.find(params[:picture_id])
    respond_to do |format|
      format.html
      format.js
    end
  end
end
