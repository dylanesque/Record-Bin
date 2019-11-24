Rails.application.routes.draw do
  get 'wishlist/index'
  devise_for :users
  resources :albums do
    resources :reviews
  end
  root 'albums#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
