# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  resources :cards do
    resources :answers, only: [:create]
  end

  resources :users, except: %i[index destroy]
  resources :user_sessions, only: %i[new create destroy]
end
