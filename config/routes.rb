Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    concern :imageable do
      resources :images, only: :create
    end

    resources :users, concerns: [:imageable]
    resources :users
    namespace :admin do
      resources :users
      resources :exams do
        resources :questions do
          resources :answers
        end
      end
    end
    namespace :user do
      resources :exams do
        resources :result_exams
        resources :questions do
          resources :answers
        end
      end
    end
    resources :password_resets
  end
end
