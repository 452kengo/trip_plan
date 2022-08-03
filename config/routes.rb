Rails.application.routes.draw do
  resources :plans
  devise_for :users, controllers: { registrations: 'users/registrations',
                                    sessions: 'users/sessions' }
  root to: "home#index"
  resources :places
  get 'maps/index'
  root to: 'maps#index'
  resources :maps, only: [:index, :create]
end
