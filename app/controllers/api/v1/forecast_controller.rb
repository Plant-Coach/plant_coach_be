class Api::V1::ForecastController < ApplicationController
  def create
    forecast_data = ForecastFacade.get_forecast(params[:location])
    render json: ForecastSerializer.new(forecast_data)
  end
end
