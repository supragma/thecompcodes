Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'aboutus', to: 'aboutus#index'
  get 'terms', to: 'terms#index'
  get 'privacy', to: 'privacy#index'
  get 'services', to: 'services#index'
  # Set paths for the API.
  namespace :api, default: {format: :json} do
    namespace :v1 do
      get 'liveness', to: 'liveness#success'
      get 'failure', to: 'liveness#failure'
    end
  end
end
