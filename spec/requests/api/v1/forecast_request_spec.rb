require 'rails_helper'

RSpec.describe 'Forecast API Endpoint' do
  describe 'POST /forecast' do
    it 'returns the forecast based on the users zip code' do
      body = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body
      user_response = JSON.parse(response.body, symbolize_names: true)

      get '/api/v1/forecast', headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }

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
