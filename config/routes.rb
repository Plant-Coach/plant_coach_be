Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :update, :destroy]
      resources :garden_plants, only: [:index, :create, :update, :destroy]
      resources :sessions, only: [:create, :destroy]
      resources :forecast, only: [:index]
      resources :plants, only: [:index, :create, :show, :update, :destroy]
      resources :frost_dates, only: [:index]
      resources :alert_check, only: [:create]
      resources :garden_reminder, only: [:create]
      resources :started_indoor_seeds, only: [:index]
      resources :plants_waiting_to_be_started, only: [:index]
      resources :plants_in_the_garden, only: [:index]
      resources :plant_guides, only: [:index, :create, :show, :update, :destroy]
    end
  end
end
