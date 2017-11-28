Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]

  resources :blogs do
    collection do
      post :confirm
      get :favorite
      get :users
      post :blog_images

    end
  end

  resources :users, only: [:new, :create, :edit]

  resources :favorites, only: [:create, :destroy]

  resources :feeds, only:[:create, :update]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
