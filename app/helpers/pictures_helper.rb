module PicturesHelper
  def choose_home_or_edit
    if action_name == 'home' || action_name == 'confirm'
      confirm_pictures_path
    elsif action_name == 'edit'
   #update
      picture_path
    end
  end
end
