Rails.application.routes.draw do
  root 'pages#index'
  
  devise_for :users

  get '/contact', to: 'pages#contact'
  get '/team', to: 'pages#team'

  namespace :app do
    get '/', to: 'pages#index'
    get '/projects', to: 'pages/projects#index'
    get '/settings', to: 'pages/settings#index'
    get '/team', to: 'pages/team#index'
    get '/users', to: 'pages/users#index'
  end
end
