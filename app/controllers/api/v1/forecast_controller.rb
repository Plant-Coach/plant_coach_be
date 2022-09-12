class Api::V1::ForecastController < ApplicationController
  # Returns an 8-day forecast for a user based on their zip code.
  def index
    # Returns an array of forecasts for the user's zip code.
    forecast_data = ForecastFacade.get_forecast(@user.zip_code)
    render json: ForecastSerializer.new(forecast_data)
  end
end
