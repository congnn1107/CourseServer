Rails.application.routes.draw do
  default_url_options host: ENV['HOST'], port: ENV['PORT']

  namespace :api do
    namespace :v1 do
      namespace :admin do
        post '/login', to: 'sessions#create'
        resources :courses do
        end
        resources :users
      end

      namespace :users do
        post '/register', to: 'users#create'
        post '/login', to: 'sessions#create'
        get '/profile', to: 'users#show'
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
