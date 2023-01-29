require 'rails_helper'

RSpec.describe 'Forecast API Endpoint' do
  describe 'POST /forecast' do
    it 'returns the forecast based on the users zip code' do
      json_response = File.read('spec/fixtures/get_frost_dates_request.json')
      stub_request(:get, "https://glacial-fjord-58347.herokuapp.com/api/v1/frost?zip_code=80121")
      .with(
        headers: {
          'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v2.5.2'
          }
          ).
          to_return(status: 200, body: json_response, headers: {})

      body = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body
      user_response = JSON.parse(response.body, symbolize_names: true)

      forecast_json_response = File.read('spec/fixtures/get_user_forecast_request.json')
      stub_request(:post, "https://glacial-fjord-58347.herokuapp.com/api/v1/forecast").
         with(
           body: {"location"=>"80121"},
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'Content-Type'=>'application/x-www-form-urlencoded',
       	  'User-Agent'=>'Faraday v2.5.2'
           }).
         to_return(status: 200, body: forecast_json_response, headers: {})

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
