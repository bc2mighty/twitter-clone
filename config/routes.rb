Rails.application.routes.draw do

  root 'landing#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout' => 'sessions#logout'
  get '/loggedout' => 'sessions#loggedout'
  
  resources :followers
  resources :users
  resources :tweets
  get 'landing/index'
  get '/:username' , to: 'users#profile'
  get 'follow/:username' , to: 'followers#follow'
  get 'unfollow/:username' , to: 'followers#unfollow'

  resources :messages, only: [:new, :create]
  resources :tweets, only: [:new, :create]
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
