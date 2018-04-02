Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    delete 'logout', to: 'devise/sessions#destroy'
  end
  root 'users#index'
  resources :users, only: [:index, :show] do
      resources :weeks, only: [:create, :show, :index]
      resources :tasks, only: [:create, :new]
    end
  get '/calendars', to: 'application#calendars'

end
