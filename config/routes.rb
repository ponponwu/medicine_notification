Rails.application.routes.draw do
  devise_for :users
  resources :notifications, only: %i(create)
  resources :records,       only: %i(create)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
