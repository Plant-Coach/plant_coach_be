require 'rails_helper'

RSpec.describe 'Forecast API Endpoint' do
  describe 'POST /forecast' do
    it 'returns the forecast based on the users zip code' do
      location_params = { "location": 80112 }
      post '/api/v1/forecast', params: location_params
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(result).to be_a Hash

      expect(result).to have_key(:data)
      result[:data].each do |weather|
        expect(weather).to have_key(:id)
        expect(weather).to have_key(:type)
        expect(weather).to have_key(:attributes)
        expect(weather[:attributes]).to have_key(:id)
        expect(weather[:attributes]).to have_key(:date)
        expect(weather[:attributes]).to have_key(:sunrise)
        expect(weather[:attributes]).to have_key(:sunset)
        expect(weather[:attributes]).to have_key(:high)
        expect(weather[:attributes]).to have_key(:low)
        expect(weather[:attributes]).to have_key(:humidity)
        expect(weather[:attributes]).to have_key(:wind)
        expect(weather[:attributes]).to have_key(:weather)
      end
    end
  end
end
