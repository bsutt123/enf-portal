Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  devise_scope :user do
    match 'sessions/user', to: 'users/sessions#create', via: :post
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'welcome/index'
  root 'welcome#index'

  resources :counselors
  resources :sessions
  resources :cabins
end
