Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'registrations'
  }
  
  root "home#index"
  get "/home", to: "home#index"
  get "/profile", to: "home#profile"
  get "/profile/services", to: "home#profile_services"

  resources :services
  resources :trades
end