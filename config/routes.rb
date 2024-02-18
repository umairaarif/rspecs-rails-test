Rails.application.routes.draw do
  resources :products
  get 'health/index'
  root 'products#index'
end
