Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :update]
      resources :user_plants, only: [:index, :create, :destroy]
      resources :sessions, only: [:create]
      resources :forecast, only: [:index]
      resources :plants, only: [:index, :create, :update, :destroy]
      resources :frost_dates, only: [:index]
    end
  end
end
