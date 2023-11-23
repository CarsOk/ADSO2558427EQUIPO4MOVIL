Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    confirmations: 'users/confirmations'
  }

  devise_scope :user do
    post 'users/confirmation', to: 'users/confirmations#verify_code'
  end

  resources :orders, only: [:index, :new, :create]

  get '/users/show', to: 'users#show'
end
