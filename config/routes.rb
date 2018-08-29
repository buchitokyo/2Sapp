Rails.application.routes.draw do

  get 'sessions/new'

  root to:'static_pages#home'

  #resources :pictures, only: [:create, :destroy]

  get  '/help', to:'static_pages#help'
  get  '/signup', to: 'users#new'
  get  '/home', to:'static_pages#home'
  #get  '/static_pages',to:'static_pages#about'

  get '/login', to: 'sessions#new'
  #postで送りますよ
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users

  resources :pictures do
    collection do
      post :confirm
    end
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
