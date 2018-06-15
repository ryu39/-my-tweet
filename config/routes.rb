Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :applications, :authorized_applications, :token_info
  end

  resource :session, only: [:new, :create, :destroy]
  resources :tweets, only: [:index]
  namespace :api do
    resources :tweets, only: [:index, :show, :create, :update, :destroy]
  end

  root to: 'sessions#new'
end
