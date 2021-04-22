Rails.application.routes.draw do
  devise_for :corporations, controllers: {
    sessions:      'corporations/sessions',
    passwords:     'corporations/passwords',
    registrations: 'corporations/registrations'
  }
  devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }
  root to: 'items#index'
  resources :items
  resources :carts, only: [:show,:destroy] do
    resources :orders, only: [:index,:create]
  end
    

  post '/add_item' => 'carts#add_item'
  delete '/delete_item' => 'carts#delete_item'
end
