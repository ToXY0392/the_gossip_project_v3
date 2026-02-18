Rails.application.routes.draw do
  root "pages#home"

  get "/team", to: "pages#team", as: :team
  get "/contact", to: "pages#contact", as: :contact
  get "/welcome/:first_name", to: "pages#welcome", as: :welcome

  get  "/signup", to: "users#new",    as: :signup
  post "/signup", to: "users#create", as: :users

  get  "/login",  to: "sessions#new",     as: :login
  post "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  resources :cities, only: [:show]
  resources :gossips, only: [:show, :new, :create, :edit, :update, :destroy] do
    resources :comments, only: [:create]
  end
  resources :comments, only: [:edit, :update, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :users, only: [:show]
end
