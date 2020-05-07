Rails.application.routes.draw do
  root to:"home#index"
  get "/about" => "home#about"
  
  get "/login" => "users#login_form"
  post "/login" => "users#login"
  post "/logout" => "users#logout"
  get "/signup" => "users#new"
  post "/users/create" => "users#create"
  get "/users" => "users#index"
  get "/users/:id" => "users#show"
  get "/users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"
  
  get "/posts" => "posts#index"
  get "/posts/new" =>"posts#new"
  post "/posts/create" =>"posts#create"
  get "/posts/:id" => "posts#show"
  get "/posts/:id/edit" => "posts#edit"
  post "/posts/:id/update" => "posts#update"
  post "/posts/:id/destroy" => "posts#destroy"
  
end
