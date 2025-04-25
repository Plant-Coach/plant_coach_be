require 'rails_helper'

RSpec.describe ForecastFacade, :vcr do
  describe '::get_forecast' do
    xit 'returns the forecast from the service' do
      data = ForecastFacade.get_forecast("80112")

      expect(data.count).to eq(8)

      data.each do |forecast|
        expect(forecast.date).to be_a Date
        expect(forecast.high).to be_a(Float).or be_a(Integer)
        expect(forecast.humidity).to be_a Integer
        expect(forecast.id).to be nil
        expect(forecast.low).to be_a(Float).or be_a(Integer)
        expect(forecast.sunrise.to_time).to be_a Time
        expect(forecast.sunset.to_time).to be_a Time
        expect(forecast.weather).to be_a String
        expect(forecast.wind).to be_a(Float).or be_a(Integer)
      end
    end
  end
end
