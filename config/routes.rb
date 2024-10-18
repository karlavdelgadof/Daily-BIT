Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'bitcoin_price#show'

  resources :users, only: [:create, :show, :update, :destroy] do
    resources :transactions, only: [:create, :index, :show]
  end
end
