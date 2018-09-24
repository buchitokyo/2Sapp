Rails.application.routes.draw do
  root to:'static_pages#home'

  get  '/home', to:'static_pages#home'
  get  '/about', to:'static_pages#about'
  get  '/signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  #postで送りますよ
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  #memberメソッドを使うとユーザーidが含まれているURLを使用できる　stat/html参照　following_user_path(@user)
    resources :users do
      member do
        get :following, :followers
      end
    end

  resources :pictures do
    resources :comments
    collection do
      post :confirm
    end
    resources :likes, only: [:create, :destroy]
  end

  resources :relationships,only: [:create, :destroy]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
