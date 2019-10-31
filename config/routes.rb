# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'
  post '/check_answer' => 'home#check_answer'
  post '/next_card' => 'home#next_card'

  resources :cards
end
