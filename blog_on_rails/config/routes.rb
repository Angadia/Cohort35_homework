Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/", to: "posts#index", as: "root"
  resources :posts, except: [:index] do
    resources :comments, only: [:create, :destroy]
  end

  get "/users/:id/password", to: "users#password", as: "user_password"
  patch "/users/:id/password", to: "users#update_password"
  resources :users, only: [:new, :create, :edit, :update]
  resource :session, only: [:new, :create, :destroy]
end
