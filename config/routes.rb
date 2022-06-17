Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :favorites, only: [:create, :destroy]
  resources :favorites, only: [ :create, :destroy]
  resources :pictures do
  collection do
    post :confirm
    end  
  end

end
