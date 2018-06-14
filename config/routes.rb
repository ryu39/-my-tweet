Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :tweets, only: [:index]

  root to: 'sessions#new'
end
