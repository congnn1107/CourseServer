Rails.application.routes.draw do
  default_url_options host: "localhost", port: "3000"

  namespace :api do
    namespace :v1 do
      namespace :admin do
        post "/login", to: "sessions#create"
        resources :billboards
        resources :categories
        get "/courses/search", to: "courses#search"
        resources :courses do
          resources :lessons
          resources :quizzes do
            resources :questions do
              resources :answers
            end
          end
          resources :reviews
        end
        resources :users
      end

      namespace :users do
        post "/register", to: "users#create"
        post "/login", to: "sessions#create"
        get "/profile", to: "users#show"
        # get "/courses", to: "courses#index"
        get "/courses/search", to: "courses#search"
        get "/categories", to: "categories#index"
        get "/billboards", to: "billboards#index"
        resources :courses do
          resources :lessons
          resources :quizzes do
            post "submit", to: "quizzes#start"
            put "submit", to: "quizzes#submit"
          end
          get "reviews/statistics", to: "reviews#statistics"
          resources :reviews
          delete "reviews", to: "reviews#destroy"
          put "reviews", to: "reviews#update"
        end

        put "/lessons/:id/view", to: "lessons#update"
        put "/courses/:id/subscribes/1", to: "course_subscribes#update"
        resources :course_subscribes, path: "/courses/:id/subscribes"
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
