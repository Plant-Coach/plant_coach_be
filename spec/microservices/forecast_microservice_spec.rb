require 'rails_helper'

RSpec.describe ForecastMicroservice do
  describe '::get_forecast' do
    it 'returns the forecast for the zip code provided' do
      zip_code = 80112
      data = ForecastMicroservice.get_forecast(zip_code)
      require 'pry'; binding.pry
    end
  end
end
