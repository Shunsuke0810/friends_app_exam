Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:edit, :update, :new, :create, :show]
  resources :favorites, only: [:index, :create, :destroy]
  resources :pictures do
  collection do
    post :confirm
    end  
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

end
