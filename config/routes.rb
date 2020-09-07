Rails.application.routes.draw do
  devise_for :collaborators, controllers: { registrations: 'collaborators/registrations' }
  root to: 'home#index'

  resources :products, only: [:new, :create]
end
