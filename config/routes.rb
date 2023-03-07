require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  root :to => 'home#index'
  resources :clients
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope module: :api do
    namespace :v1 do
      resources :blobs, only: [:create, :show]
      resources :clients do
        collection do
          post :access_token
        end
      end
    end
  end
end
