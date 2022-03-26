require 'rails_helper'

RSpec.describe 'User Sessions' do
  describe 'POST /sessions' do
    it 'logs in a user' do
      body = { name: 'Joel Grant', email: 'joel@plantcoach.com', zip_code: '80121', password: '12345', password_confirmation: '12345' }
      post '/api/v1/users', params: body

      expect(response).to be_successful

      login_params = { email: 'joel@plantcoach.com', password: '12345' }
      post '/api/v1/sessions', params: login_params

      expect(response).to be_successful
    end

    it 'returns an error if the password is bad' do
      body = { name: 'Joel Grant', email: 'joel@plantcoach.com', zip_code: '80121', password: '12345', password_confirmation: '12345' }
      post '/api/v1/users', params: body

      expect(response).to be_successful

      login_params = { email: 'joel@plantcoach.com', password: 'WRONG PASSWORD' }
      post '/api/v1/sessions', params: login_params

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:error]).to eq("Your credentials are incorrect!")
    end
  end
end
