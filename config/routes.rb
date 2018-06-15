Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :applications, :authorized_applications, :token_info
  end

  resource :session, only: [:new, :create, :destroy]
  resources :tweets, only: [:index]

  root to: 'sessions#new'
end
