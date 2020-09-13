Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'static_pages#home'
  devise_for :users,
             path: '',
             path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration' },
             controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
  end

  namespace :admin do
    resources :categories, only: [:index, :show, :create, :update]
    resources :tours do
      resources :tour_details, only: [:create, :edit, :update, :destroy]
      resources :images, only: [:create, :destroy]
    end
  end
  get "/admin", to: "admin/dash_board#home"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
