# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'statuses#index'

  # resolve('activity') { [:activities] }

  post '/login', to: 'auth#login'
  get '/auto_login', to: 'auth#auto_login'
  get '/user_is_authed', to: 'auth#user_is_authed'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :requests, only: [:index]
      resources :users

      # resource :activity
    end
  end
end
