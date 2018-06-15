Rails.application.routes.draw do
  use_doorkeeper
  resource :session, only: [:new, :create, :destroy]
  resources :tweets, only: [:index]

  root to: 'sessions#new'
end
