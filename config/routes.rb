Rails.application.routes.draw do
  root 'pages#index'
  
  devise_for :users
  
  get '/team', to: 'pages#team'
  resources :projects
  get '/contact', to: 'pages#contact'

  namespace :app do
    get '/', to: 'pages#index'
    resources :profile, controller: 'pages/profile'
    get '/projects', to: 'pages/projects#index'
    get '/settings', to: 'pages/settings#index'
    get '/team', to: 'pages/team#index'
    resources :users, controller: 'pages/users'
  end
end
