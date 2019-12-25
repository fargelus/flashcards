# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /en/ do
    root to: 'home#index'
  end

  scope '(:locale)', locale: /en/ do
    resources :decks do
      resources :cards
    end
  end

  resources :cards, only: [] do
    resources :answers, only: %i[create update]
  end

  scope '(:locale)', locale: /en/ do
    resources :users, except: %i[index destroy]
  end

  resources :user_sessions, only: %i[new create destroy]
  scope '(:locale)', locale: /en/ do
    get 'login' => 'user_sessions#new', as: :login
  end

  delete 'logout' => 'user_sessions#destroy', as: :logout

  get 'oauth/callback' => 'oauths#callback' # For github
  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider
end
