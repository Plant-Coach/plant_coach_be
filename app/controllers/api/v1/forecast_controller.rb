class Api::V1::ForecastController < ApplicationController
  # This is making the forecast request from being an authenticated call.
  skip_before_action :authorized, only: [:create]

  def create
    forecast_data = ForecastFacade.get_forecast(params[:location])
    render json: ForecastSerializer.new(forecast_data)
  end
end
