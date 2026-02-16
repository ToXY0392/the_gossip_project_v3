Rails.application.routes.draw do
root "pages#home"
get "/team", to: "pages#team", as: :team
get "/contact", to: "pages#contact", as: :contact
get "/welcome/:first_name", to: "pages#welcome", as: :welcome
get "/gossips/:id", to: "gossips#show", as: :gossip
get "/users/:id", to: "users#show", as: :user
end
