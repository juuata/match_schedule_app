Rails.application.routes.draw do
  root "leagues#index"

  # 認証関連
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :leagues, only: [:index]

  resources :matches, only: [:index, :show] do
    collection do
      get :schedule
      get :results
      get :live
      get :standings
    end
  end

  resources :favorites, only: [:index, :create]
  delete "favorites", to: "favorites#destroy"

  get "up" => "rails/health#show", as: :rails_health_check
end
