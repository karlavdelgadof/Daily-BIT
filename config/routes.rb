# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'bitcoin_price#show'

  resources :users, only: %i[create show update destroy] do
    resources :transactions, only: %i[create index show]
  end
end
