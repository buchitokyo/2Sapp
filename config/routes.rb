Rails.application.routes.draw do

  get 'sessions/new'

  root to:'static_pages#home'

  #resources :pictures, only: [:create, :destroy]

  get  '/about', to:'static_pages#about'
  get  '/signup', to: 'users#new'
  get  '/home', to:'static_pages#home'
  #get  '/static_pages',to:'static_pages#about'

  get '/login', to: 'sessions#new'
  #postで送りますよ
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :pictures do
    resources :likes, only: [:create, :destroy]
    resources :comments
    collection do
      post :confirm
    end
  end

#memberメソッドを使うとユーザーidが含まれているURLを使用できる　stat/html参照　following_user_path(@user)
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :relationships,only: [:create, :destroy]



  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
