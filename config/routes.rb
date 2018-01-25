Rails.application.routes.draw do
  root 'blogs#top'
  resources :users
  resources :sessions, only: [:new, :create, :edit, :destroy]
  resources :favorites, only: [:create, :destroy]
  
  resources :blogs do
    collection do
      post :confirm
      get :favorite
      get :top
      #get :users
    end
  end
end
