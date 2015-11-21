Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :workers
  devise_for :costumers
  devise_for :users
  resources :workers
  resources :costumers
end
