Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    delete 'logout', to: 'devise/sessions#destroy'
  end
  root 'users#index'
  get '/privacy', to: 'static_pages#privacy' 
  resources :users, only: [:index, :show] do
      resources :weeks, only: [:create, :show, :index] do
        resources :days, only: [:create, :show, :index] do
        end
      end
      resources :tasks, only: [:create, :new, :edit, :update, :destroy]
    end
  get '/calendars', to: 'application#calendars'

end
