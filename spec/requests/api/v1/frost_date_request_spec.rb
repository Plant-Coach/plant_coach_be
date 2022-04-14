require 'rails_helper'

RSpec.describe 'Frost Date API Endpoint' do
  describe 'GET /frost_data' do
    it 'returns the the spring and fall frost dates in addition to more details location data' do
      body = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body
      user_response = JSON.parse(response.body, symbolize_names: true)

      get '/api/v1/frost_dates', headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(result).to be_a Hash
      expect(result).to have_key(:data)

      expect(result[:data][:attributes]).to be_a Hash
      expect(result[:data][:attributes]).to have_key(:id)
      expect(result[:data][:attributes]).to have_key(:zip_code)
      expect(result[:data][:attributes]).to have_key(:location_name)
      expect(result[:data][:attributes]).to have_key(:lat)
      expect(result[:data][:attributes]).to have_key(:lon)
      expect(result[:data][:attributes]).to have_key(:spring_frost)
      expect(result[:data][:attributes]).to have_key(:fall_frost)
    end
  end
end
