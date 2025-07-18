Rails.application.routes.draw do

  get "/rails/health" => "rails/health#show", as: :rails_health_check
  get "/rails/ready" => "rails/ready#show", as: :rails_ready_check

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index create update destroy]
      resources :garden_plants, only: %i[index create update destroy]
      resources :sessions, only: %i[create destroy]
      resources :forecast, only: [:index]
      resources :plants, only: %i[index create show update destroy]
      resources :frost_dates, only: [:index]
      resources :alert_check, only: [:create]
      resources :garden_reminder, only: [:create]
      resources :started_indoor_seeds, only: [:index]
      resources :plants_waiting_to_be_started, only: [:index]
      resources :plants_in_the_garden, only: [:index]
      resources :plant_guides, only: %i[index create show update destroy]
    end
  end
end
