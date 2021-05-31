Rails.application.routes.draw do
  resources :payments, only: [:new, :create]

  devise_for :users, controllers: {
    registrations: 'registrations'
  }
  
  root "home#index"
  get "/home", to: "home#index"
  get "/profile", to: "home#profile"
  get "/profile/services", to: "home#profile_services"
  get "/coins", to: "home#coins", as: "coins"
  get "/paymenthistory", to:"home#payment_history", as: "payment_history"

  resources :services
  resources :trades, only: [:new, :create, :index, :update]
  get "/trades/archived", to: "trades#archived"

  resources :reviews, only: [:create]

end