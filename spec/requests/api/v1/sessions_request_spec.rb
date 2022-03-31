require 'rails_helper'

RSpec.describe 'User Sessions' do
  describe 'POST /sessions' do
    it 'logs in a user' do
      body = { name: 'Joel Grant', email: 'joel@plantcoach.com', zip_code: '80121', password: '12345', password_confirmation: '12345' }
      post '/api/v1/users', params: body
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      login_params = { email: 'joel@plantcoach.com', password: '12345' }
      post '/api/v1/sessions', params: login_params, headers: { Authorization: "Bearer #{user_response[:jwt]}" }

      expect(response).to be_successful
    end

    it 'returns an error if the password is bad' do
      body = { name: 'Joel Grant', email: 'joel@plantcoach.com', zip_code: '80121', password: '12345', password_confirmation: '12345' }
      post '/api/v1/users', params: body
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      login_params = { email: 'joel@plantcoach.com', password: 'WRONG PASSWORD' }
      post '/api/v1/sessions', params: login_params, headers: { Authorization: "Bearer #{user_response[:jwt]}" }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:error]).to eq("Your credentials are incorrect!")
    end

    it 'returns an error if the user doesnt exist' do
      body = { name: 'Joel Grant', email: 'joel@plantcoach.com', zip_code: '80121', password: '12345', password_confirmation: '12345' }
      post '/api/v1/users', params: body
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful

      non_existent_user = {email: 'joe12345@shmo.com', password: 'ABCDE'}
      post '/api/v1/sessions', params: non_existent_user, headers: { Authorization: "Bearer #{user_response[:jwt]}" }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:error]).to eq("Your credentials are incorrect!")
    end
  end
end
