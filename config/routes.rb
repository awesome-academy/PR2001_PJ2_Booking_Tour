require "sidekiq/web"

Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root 'static_pages#home'
    mount Sidekiq::Web => '/admin/sidekiq'
    devise_for :users, skip: :omniauth_callbacks,
               path: '',
               path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration' },
               controllers: { sessions: 'users/sessions' }

    namespace :admin do
      resources :categories
      scope module: "categories" do
        resources :categories, only: [] do
          resources :images, only: [:create, :destroy]
        end
      end

      resources :tours do
        resources :tour_details, only: [:create, :edit, :update, :destroy]  
      end

      resources :hotels
      scope module: "hotels" do
        resources :hotels, only: [] do
          resources :images, only: [:create, :destroy]
        end
      end

      resources :users, only: [:index, :destroy]
      resources :campaigns, only: [:create, :index, :destroy, :new]
      resources :coupons, only: [:index, :destroy]
      resources :coupons_users, only: [:index, :destroy]
    end

    resources :categories, only: [:show, :index]  do
      resources :tours, only: [:index, :show]
    end

    namespace :search do
      resources :tours, only: :index
    end

    namespace :area do
      resources :categories, only: :index
    end

    resources :tours, only: [] do
      resources :booking_tours
    end

    resources :users, only: :show
    
    get "/admin", to: "admin/dash_board#home"
    get "/login", to: "devise/sessions#new"
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'omniauth_callbacks'}
end
