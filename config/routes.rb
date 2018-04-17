Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    delete 'logout', to: 'devise/sessions#destroy'
  end
  root 'users#index'
  get '/privacy', to: 'static_pages#privacy' 
  resources :users, only: [:index, :show, :edit, :update] do
    get '/settings', to: 'users#settings'
    get '/welcome', to: 'users#settings'
      resources :weeks, only: [:create, :show, :index] do
        resources :days, only: [:create, :show, :index]
      end
      resources :tasks, only: [:create, :new, :edit, :update, :destroy]
    end
  get '/calendars', to: 'application#calendars'

end
