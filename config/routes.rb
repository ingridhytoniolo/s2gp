Rails.application.routes.draw do
  root 'pages#index'
  
  devise_for :users
  
  get '/team', to: 'pages#team'
  resources :projects, only: [:index, :show]
  get '/contact', to: 'pages#contact'

  namespace :app do
    get '/', to: 'pages#index'
    resources :announcements, controller: 'pages/announcements'
    resources :events, controller: 'pages/events'
    resources :meetings, controller: 'pages/meetings' do
      get '/edit_minutes', to: 'pages/meetings#edit_minutes'
      get '/minutes', to: 'pages/meetings#minutes'
    end
    resources :news, controller: 'pages/news'
    resources :profile, controller: 'pages/profile' do
      get :new_avatar, to: 'pages/profile#new_avatar'
      delete :delete_avatar, to: 'pages/profile#delete_avatar'
    end
    resources :projects, controller: 'pages/projects' do
      post :join, to: 'pages/projects#join'
      resources :activities, controller: 'pages/active_project/activities'
      resources :meetings, controller: 'pages/active_project/meetings'
      resources :members, controller: 'pages/active_project/members'
      resources :resources, controller: 'pages/active_project/resources', only: [:index] do
        post :remove, to: 'pages/active_project/resources#remove'
      end
      get '/resources/add', to: 'pages/active_project/resources#add'
      post '/resources/associate', to: 'pages/active_project/resources#associate'
    end
    resources :resources, controller: 'pages/resources'
    resources :settings, controller: 'pages/settings', only: [:edit, :index, :update] do
      delete :delete_image, to: 'pages/settings#delete_image'
    end
    resources :users, controller: 'pages/users'
  end
end
