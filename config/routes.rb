Rails.application.routes.draw do
  root to:"home#index"
  get "/about" => "home#about"
  
  get "/signup" => "users#new"
  post "/user/:id/create" => "users#create"
  
  get "/posts" => "posts#index"
  get "/posts/new" =>"posts#new"
  post "/posts/create" =>"posts#create"
  get "/posts/:id" => "posts#show"
  get "/posts/:id/edit" => "posts#edit"
  post "/posts/:id/update" => "posts#update"
  post "/posts/:id/destroy" => "posts#destroy"
  
end
