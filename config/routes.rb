Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :services
  resources :trades
  resources :reviews
end