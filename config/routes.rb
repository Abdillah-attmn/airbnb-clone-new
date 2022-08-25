Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :cars do
    resources :bookings, only: :create
  end

  resources :bookings, except: %i[new edit create] do
    resources :reviews, only: %i[index show create]

    get '/booking_loueur', to: 'booking#list'  # /bookings/lists
  end

  get '/bookings/booking_renter', to: 'bookings#list_renter'  # /bookings/lists
end
