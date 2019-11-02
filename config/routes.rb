# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  resources :cards do
    post 'check_answer', on: :member
  end
end
