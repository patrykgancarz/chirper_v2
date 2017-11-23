Rails.application.routes.draw do
  resources :comments
  resources :posts
  resources :groups
  resources :users
  root to: 'static#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
