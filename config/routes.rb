Rails.application.routes.draw do
  devise_for :collaborators, controllers: { registrations: 'collaborators/registrations' }
  get 'home/search', to: 'home#search'
  get 'orders/completed', to: 'orders#completed'
  root to: 'home#index'

  resources :products, only: %i[new create show index update]
  resources :orders, only: %i[create show index update]
  resources :collaborators, only: :show
  resources :order_messages, only: :create
end
