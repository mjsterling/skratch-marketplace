Rails.application.routes.draw do
  devise_for :users
  
  root "home#index"
  get "/home", to: "home#index"
  get "/profile", to: "home#profile"

  resources :services
  resources :trades
  resources :reviews
end