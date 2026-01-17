Rails.application.routes.draw do
  root "leagues#index"

  resources :leagues, only: [:index]

  resources :matches, only: [:index, :show] do
    collection do
      get :schedule
      get :results
      get :live
      get :standings
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
