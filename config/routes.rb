Rails.application.routes.draw do
  devise_for :users

  root 'searches#show'

  resources :tickets
  resource :search, only: [:show, :create]

  namespace :admin do
    root 'panel#index'

    resources :railway_stations do
      patch :update_position, on: :member
      patch :update_time, on: :member
    end

    resources :trains do
      resources :carriages
    end

    resources :routes
    resources :tickets
    resources :panel, only: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
