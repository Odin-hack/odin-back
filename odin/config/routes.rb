Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    resources :campaign, only: [:index, :show, :create, :update]
  end
end
