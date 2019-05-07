Rails.application.routes.draw do
  # get 'users/new'
  # get 'sessions/new'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  get 'signup', to: 'users#new', as: 'signup'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'welcome/index'

  resources :tweets do
    resources :likes, :dislikes
  end
  resources :sessions
  resources :users do
    resources :tweets, :likes, :dislikes
  end

  root 'sessions#new'
end