Rails.application.routes.draw do
  root 'pages#index'
  
  devise_for :users
  
  get '/team', to: 'pages#team'
  resources :projects, only: [:index, :show]
  get '/contact', to: 'pages#contact'

  namespace :app do
    get '/', to: 'pages#index'
    resources :profile, controller: 'pages/profile' do
      get :new_avatar, to: 'pages/profile#new_avatar'
      delete :delete_avatar, to: 'pages/profile#delete_avatar'
    end
    resources :projects, controller: 'pages/projects' do
      post :join, to: 'pages/projects#join'
      get :dashboard, to: 'pages/active_project#dashboard'
      resources :activities, controller: 'pages/active_project/activities'
      resources :meetings, controller: 'pages/active_project/meetings'
      resources :members, controller: 'pages/active_project/members'
      resources :news, controller: 'pages/active_project/news', only: [:index]
      resources :resources, controller: 'pages/active_project/resources'
    end
    get '/settings', to: 'pages/settings#index'
    resources :users, controller: 'pages/users'
  end
end
