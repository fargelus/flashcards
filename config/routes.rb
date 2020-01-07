# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: 'welcome' do
    root to: 'home#index'

    resources :users, only: %i[new create]
    resources :user_sessions, only: %i[create]
    get 'login' => 'user_sessions#new', as: :login

    get 'oauth/callback' => 'oauths#callback' # For github
    post 'oauth/callback' => 'oauths#callback'
    get 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider
  end

  namespace :dashboard do
    resources :decks, except: :show do
      resources :cards, except: :show
    end

    resources :cards, only: [] do
      resources :answers, only: %i[create update]
    end

    resources :users, only: %i[edit update]
    delete 'logout' => 'user_sessions#destroy', as: :logout
  end
end
