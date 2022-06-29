Rails.application.routes.draw do
  resources :places
    get 'maps/index'
    root to: 'maps#index'
    resources :maps, only: [:index]
end
