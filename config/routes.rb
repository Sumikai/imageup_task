Rails.application.routes.draw do
  root 'blogs#index'
  
  resources :blogs do
    collection do
      post :confirm
    end
  end
end
