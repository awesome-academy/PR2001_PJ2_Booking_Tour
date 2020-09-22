require "sidekiq/web"

Rails.application.routes.draw do
  root 'static_pages#home'
  mount Sidekiq::Web => '/admin/sidekiq'
  devise_for :users,
             path: '',
             path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration' },
             controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  namespace :admin do
    resources :categories, except: :new
    scope module: "categories" do
      resources :images, only: [:create, :destroy]
    end

    resources :tours do
      resources :tour_details, only: [:create, :edit, :update, :destroy]  
    end

    resources :hotels
    scope module: "hotels" do
      resources :hotels do
        resources :images, only: [:create, :destroy]
      end
    end

    scope module: "tours" do
      resources :tours do
        resources :images, only: [:create, :destroy]
      end
    end

    resources :campaigns, only: [:create, :index, :destroy]
    resources :coupons, only: [:index, :destroy]
    resources :coupons_users, only: [:index, :destroy]
  end

  resources :categories, only: []  do
    resources :tours, only: [:index, :show]
  end

  namespace :search do
    resources :tours, only: :index
  end

  resources :tours, only: [] do
    resources :booking_tours
  end

  resources :users, only: :show
  
  get "/admin", to: "admin/dash_board#home"
  get "/login", to: "devise/sessions#new"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
