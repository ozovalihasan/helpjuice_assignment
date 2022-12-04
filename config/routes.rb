Rails.application.routes.draw do
  namespace :articles do
    resources :searches, only: [:index]
    resources :keywords, only: [:index]
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "articles/searches#index"
end
