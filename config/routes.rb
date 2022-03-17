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
      get :members, to: 'pages/active_project#members'
      post :members, to: 'pages/active_project#member_create'
      get 'members/new', to: 'pages/active_project#member_new'
      resources :members, only: [], controller: 'pages/active_project' do
        patch '/', to: 'pages/active_project#member_update'
        get :edit, to: 'pages/active_project#member_edit'
      end
    end
    get '/settings', to: 'pages/settings#index'
    resources :users, controller: 'pages/users'
  end
end
