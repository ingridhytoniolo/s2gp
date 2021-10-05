Rails.application.routes.draw do
  root 'pages#index'
  
  devise_for :users

  get '/contact', to: 'pages#contact'
  get '/team', to: 'pages#team'
end
