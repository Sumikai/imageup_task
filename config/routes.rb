Rails.application.routes.draw do
  root 'blogs#index'
  
  resources :blogs do
    collection do
      post :confirm
      get :top
    end
  end
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
end
