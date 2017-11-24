Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]

  resources :blogs do
    collection do
      post :confirm
      get :favorite
      get :users
    end
  end

  resources :users, only: [:new, :create]

  resources :favorites, only: [:create, :destroy]

end
