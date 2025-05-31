Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    resources :campaigns, only: [ :index, :show, :create, :update ] do
      resources :ad_groups, only: [ :index, :show, :create, :update ]
    end
  end
end
