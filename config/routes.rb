require "sidekiq/web"

Rails.application.routes.draw do
  root 'static_pages#home'
  mount Sidekiq::Web => '/admin/sidekiq'
  devise_for :users,
             path: '',
             path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration' },
             controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  namespace :admin do
    resources :categories
    resources :tours do
      resources :tour_details, only: [:create, :edit, :update, :destroy]
      resources :images, only: [:create, :destroy]
    end
  end

  resources :categories do
    resources :tours, only: [:index, :show]
  end

  namespace :search do
    resources :tours, only: :index
  end

  resources :tours, only: []  do
    resources :booking_tours
  end

  resources :users, only: :show
  get "/admin", to: "admin/dash_board#home"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
