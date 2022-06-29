Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :places
    get 'maps/index'
    root to: 'maps#index'
    resources :maps, only: [:index]
end
