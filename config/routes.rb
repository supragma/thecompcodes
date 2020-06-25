# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'statuses#index'

  # resolve('activity') { [:activities] }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post '/users/auth/login', to: 'auth#login'
      post '/users/auth/password-reset', to: 'users#send_reset_token'
      put '/users/auth/password-reset', to: 'users#reset_password'
      get '/auto_login', to: 'auth#auto_login'
      get '/user_is_authed', to: 'auth#user_is_authed'

      resources :requests, only: %i[index create]
      resources :users
      resources :workflows, only: %i[index create update show destroy]
      # resource :activity
    end
  end
end
