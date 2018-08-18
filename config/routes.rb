Rails.application.routes.draw do
  resources :pictures
  root 'static_pages#home'
  get  '/static_pages',to:'static_pages#help'
  #get  '/static_pages',to:'static_pages#about'
end
