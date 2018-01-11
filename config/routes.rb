Rails.application.routes.draw do

  root to: 'static#index'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/groups/:id/follow', to: 'groups#follow'
  get '/groups/:id/unfollow', to: 'groups#unfollow'
  get '/api' => redirect('/swagger/dist/index.html?url=/api-docs.json')
  get '/feed', to: 'static#feed'


  resources :users
  resources :groups do
    resources :posts, only: [:new, :create, :edit, :update, :show, :destroy] do
      resources :comments, only: [:new, :create, :edit, :update, :show, :destroy]
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
