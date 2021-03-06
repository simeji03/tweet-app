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
  post "/users/:id/update" => "users#update"
  get "/users/:id/likes" => "users#likes"
  get "/users/:id/followings" => "users#followings"
  get "/users/:id/followers" => "users#followers"
  
  get "/posts" => "posts#index"
  get "/posts/new" => "posts#new"
  post "/posts/create" => "posts#create"
  get "/posts/follow" => "posts#follow"
  get "/posts/:id" => "posts#show"
  get "/posts/:id/edit" => "posts#edit"
  post "/posts/:id/update" => "posts#update"
  post "/posts/:id/destroy" => "posts#destroy"
  
  post "/likes/:post_id/create" => "likes#create"
  post "/likes/:post_id/destroy" => "likes#destroy"
  
  post "/retweets/:post_id/create" => "retweets#create"
  post "/retweets/:post_id/destroy" => "retweets#destroy"
  
  resources :relationships, only: [:create, :destroy]
  
end
