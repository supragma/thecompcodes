Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Set paths for the API.
  namespace :api, default: {format: :json} do
    namespace :v1 do
      get 'liveness', to: 'liveness#success'
      get 'failure', to: 'liveness#failure'
    end
  end
end
