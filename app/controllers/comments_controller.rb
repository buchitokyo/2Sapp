class CommentsController < ApplicationController
  # コメントを保存、投稿するためのアクションです。

  def create
   # Pictureをパラメータの値から探し出し,Pictureに紐づくcommentsとしてbuildします。
    @picture = Picture.find(params[:picture_id])
    @comment = @picture.comments.build(comment_params)
    @comment.user_id = current_user.id
  # クライアント(ブラウザの)要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        # formatでindex.js.erbを呼び込む
        format.js { render :index }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @picture = Picture.find(params[:picture_id])
    respond_to do |format|
    @comment.destroy
        format.js { render :index }
    end
  end

private
# ストロングパラメーター
  def comment_params
    params.require(:comment).permit(:content, :picture_id, :user_id)
  end
end
