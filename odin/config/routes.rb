Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    resources :campaigns do
      resources :ad_groups do
        resources :ads
      end
    end
  end
end
