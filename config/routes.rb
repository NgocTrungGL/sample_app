Rails.application.routes.draw do
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :products
  root "static_pages#home"
  get 'demo_partials/new'
  get 'demo_partials/edit'
  get 'static_pages/home'
  get 'static_pages/help'
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users
  resources :account_activations, only: :edit
  resources :password_resets, only: %i(new create edit update)
<<<<<<< HEAD
  resources :microposts, only: %i(create destroy)
<<<<<<< HEAD
=======
>>>>>>> 2d88038 (Chapter 12 Reset password)
=======
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users do
    collection do
      get :tiger
    end
  end
  resources :relationships,only: %i(create destroy)
>>>>>>> d74a497 (Chapter 14 Following users)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
