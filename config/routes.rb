Rails.application.routes.draw do

  get 'sessions/new'

  root to: 'sessions#new'

  resources :pictures do
   collection do
     post :confirm
   end
 end
  get  '/help', to:'static_pages#help'
  get  '/signup', to: 'users#new'
  get  '/home', to:'static_pages#home'
  #get  '/static_pages',to:'static_pages#about'

  get '/login', to: 'sessions#new'
  #postで送りますよ
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
end
