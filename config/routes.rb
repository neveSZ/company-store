Rails.application.routes.draw do
  devise_for :collaborators, controllers: { registrations: 'collaborators/registrations' }
  get 'home/search', to: 'home#search'
  root to: 'home#index'

  resources :products, only: %i[new create show]
end
