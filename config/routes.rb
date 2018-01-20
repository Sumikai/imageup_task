Rails.application.routes.draw do
  get 'sessions/new'

  root 'blogs#index'
  
  resources :blogs do
    collection do
      post :confirm
      get :top
    end
  end
  
  resources :users, only: [:new, :create, :show, :destroy]
end
