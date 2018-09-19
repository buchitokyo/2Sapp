class PicturesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def new
   @picture = Picture.new
  end

  def confirm
   @picture = current_user.pictures.build(picture_params)
   render :new if @picture.invalid?  #:newか
  end

  def create
    #インスタンス作らなくても、modelでアソシエーションさせれば、下記の書き方になれる
    @picture = current_user.pictures.build(picture_params)

    if @picture.save
        flash[:success] = 'Picture successfully created.'
        redirect_to root_url
         #notice: 'Picture was successfully created.'
      else
         @feed_items = []
        render 'static_pages/home'
    end
  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def update
       @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
       flash[:success] = 'Picture was successfully updated.'
       #update後は、defaultでshowさせたいみたいなので
       redirect_to controller: 'static_pages', action: 'home'     #user_path(current_user)
       #notice: 'Picture was successfully updated.'
    else
       render 'edit'
    end
  end

  def destroy
    @picture.destroy
    flash[:success] = "Photo deleted"
    #request.referrerは、一つ前のURLに戻る。この時は、homeになる
    redirect_to request.referrer || root_url
  end


  private

  def picture_params
    params.require(:picture).permit(:image,:image_cache,:content)
  end

  def correct_user
    @picture = current_user.pictures.find_by(id: params[:id])
    redirect_to root_url if @picture.nil?
  end
end
