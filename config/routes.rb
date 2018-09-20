Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resource :dashboard, only: :show

  resources :games, only: [:index] do
    post :add, on: :member
    post :remove, on: :member
  end

  resources :matches, only: [:index, :new, :create]

  namespace :api do
    resources :games, only: [:index]
  end

  root to: 'dashboards#show'
end
