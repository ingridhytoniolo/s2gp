Rails.application.routes.draw do
  root 'pages#index'
  
  devise_for :users

  get '/team', to: 'pages#team'
end
