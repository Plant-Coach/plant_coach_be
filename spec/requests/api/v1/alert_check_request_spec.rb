require 'rails_helper'

RSpec.describe 'Weather Alert API Endpoints', :vcr do
  xdescribe 'POST /alert_check endpoint' do
    it 'allows a microservice request to be made for a list of zip codes' do
      body1 = {
        name: 'Joel Grant1',
        email: 'joel1@plantcoach.com',
        zip_code: '80123',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body1

      body2 = {
        name: 'Joel Grant2',
        email: 'joel2@plantcoach.com',
        zip_code: '80124',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body2

      body3 = {
        name: 'Joel Grant3',
        email: 'joel3@plantcoach.com',
        zip_code: '80125',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body3

      post '/api/v1/alert_check', headers: { Auth: "qwerty" }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      result.each do |location_data|
        expect(location_data).to have_key(:id)
        expect(location_data).to have_key(:zip)
      end
    end
  end

end
