Rails.application.routes.draw do
  get 'exams/new'
  
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    # get "/exam_cart", to: "exam_cart#new"
    # post "/exam_cart", to: "exam_carts#create"
    resources :users
    namespace :admin do
      resources :exams do
        resources :questions
      end
    end
    resources :achievements, only: [:index]
    resources :account_activations, only:[:edit]
    resources :password_resets
    resources :exam_carts
  end
end
