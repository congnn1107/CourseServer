Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :admin do
      end

      namespace :users do
        post "/register", to: "users#create"
        post "/login", to: "sessions#create"
        get "/profile", to: "users#show"
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
