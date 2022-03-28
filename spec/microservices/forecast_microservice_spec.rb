require 'rails_helper'

RSpec.describe ForecastMicroservice do
  describe '::get_forecast' do
    it 'returns the forecast for the zip code provided' do
      zip_code = "80112"
      data = ForecastMicroservice.forecast(zip_code)

      expect(data).to be_a Hash
      expect(data[:data]).to be_an Array

      data[:data].each do |weather|
        expect(weather).to have_key(:id)
        expect(weather[:id]).to be nil

        expect(weather).to have_key(:type)
        expect(weather[:type]).to be_a String
        expect(weather[:type]).to eq("forecast")

        expect(weather).to have_key(:attributes)
        expect(weather[:attributes]).to be_a Hash

        expect(weather[:attributes]).to have_key(:date)
        expect(weather[:attributes][:date]).to be_a Integer

        expect(weather[:attributes]).to have_key(:sunrise)
        expect(weather[:attributes][:sunrise]).to be_a Integer

        expect(weather[:attributes]).to have_key(:sunset)
        expect(weather[:attributes][:sunset]).to be_a Integer

        expect(weather[:attributes]).to have_key(:high)
        expect(weather[:attributes][:high]).to be_a Float

        expect(weather[:attributes]).to have_key(:low)
        expect(weather[:attributes][:low]).to be_a Float

        expect(weather[:attributes]).to have_key(:humidity)
        expect(weather[:attributes][:humidity]).to be_an Integer

        expect(weather[:attributes]).to have_key(:wind)
        expect(weather[:attributes][:wind]).to be_an Float

        expect(weather[:attributes]).to have_key(:weather)
        expect(weather[:attributes][:weather]).to be_an String
      end
    end
  end
end
