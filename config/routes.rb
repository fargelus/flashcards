# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'
  post '/check_answer' => 'home#check_answer'

  resources :cards
end
