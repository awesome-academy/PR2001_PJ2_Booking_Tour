Rails.application.routes.draw do
  root 'static_pages#home'
  devise_for :users,
             path: '',
             path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'resgistration' },
             controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
  end
  
  namespace :admin do
    resources :categories, except: :show do 
      resources :tours
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
