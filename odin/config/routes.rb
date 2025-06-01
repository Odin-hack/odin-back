Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    resources :campaigns do
      resources :ad_groups do
        resources :ads
      end
    end

    get "analytics/overview", to: "analytics#overview"
    get "analytics/ending_soon", to: "analytics#ending_soon"
    get "analytics/empty_campaigns", to: "analytics#empty_campaigns"
  end
end
