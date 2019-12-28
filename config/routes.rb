# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  resources :decks do
    resources :cards
  end

  resources :users, except: %i[index destroy]
  get 'login' => 'user_sessions#new', as: :login

  resources :cards, only: [] do
    resources :answers, only: %i[create update]
  end

  resources :user_sessions, only: %i[new create destroy]

  delete 'logout' => 'user_sessions#destroy', as: :logout

  get 'oauth/callback' => 'oauths#callback' # For github
  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider
end
