Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :workers
  devise_for :costumers
  devise_for :users
  resources :workers do
    collection do
      get 'skills_list'
    end
    get 'skills', on: :member
  end
  resources :costumers do
    collection do
      get 'search'
      get 'results'
    end
  end
end
