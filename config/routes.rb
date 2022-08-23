Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :cars do
    resources :bookings, only: :create
  end

  resources :bookings, except: %i[new edit create] do
    resources :reviews, only: %i[index show create]
  end
end
