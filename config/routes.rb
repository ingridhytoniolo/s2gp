Rails.application.routes.draw do
  root 'pages#index'
  
  devise_for :users

  get '/contact', to: 'pages#contact'
  get '/team', to: 'pages#team'

  namespace :app do
    get '/', to: 'pages#index'
    get '/team', to: 'pages/team#index'
  end
end
