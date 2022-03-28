class ForecastFacade
  def self.get_forecast(zip_code)
    forecast_data = ForecastMicroservice.forecast(zip_code)
    forecast_data[:data].map { |weather| Forecast.new(weather) }
  end
end
