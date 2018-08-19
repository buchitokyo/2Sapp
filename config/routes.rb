Rails.application.routes.draw do
  get 'users/new'

  resources :pictures do
   collection do
     post :confirm
   end
 end
  root to: 'static_pages#home'
  get  '/static_pages',to:'static_pages#help'
  #get  '/static_pages',to:'static_pages#about'
  resources :users
end
