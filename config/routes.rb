Rails.application.routes.draw do
  default_url_options host: 'localhost', port: '3000'

  namespace :api do
    namespace :v1 do
      namespace :admin do
        post "/login", to: "sessions#create"
        resources :categories
        resources :course_categories, :path => '/course-categories'
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
        resources :courses do
          resources :lessons
          resources :quizzes
          resources :reviews
          put 'reviews', to: 'reviews#update'
        end
        
        post "/courses/:id/subscribes", to: "course_subscribes#create"
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
