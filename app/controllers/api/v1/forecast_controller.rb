class Api::V1::ForecastController < ApplicationController
  # This is making the forecast request from being an authenticated call.
  # skip_before_action :authorized, only: [:index]

  def index
    forecast_data = ForecastFacade.get_forecast(@user.zip_code)
    render json: ForecastSerializer.new(forecast_data)
  end
end
