class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)  #followは、relation.rbで定義
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end


  def destroy
    #followedは、 :followeds→following
    #has_many :following, through: :active_relationships, source: :followed(usersテーブル)
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user}
      format.js
    end
  end
end
