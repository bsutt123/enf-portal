Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'welcome/index'
  root 'welcome#index'

  resources :counselors
  resources :sessions
  resources :cabins

  post ':controller(/:action(/:id(.:format)))'
  get ':controller(/:action(/:id(.:format)))'
end
