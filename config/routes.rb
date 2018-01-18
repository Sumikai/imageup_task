Rails.application.routes.draw do
  root 'blogs#index'
  #get 'twiclones/top'
  
  resources :blogs do
    collection do
      post :confirm
      get :top
    end
  end
end
