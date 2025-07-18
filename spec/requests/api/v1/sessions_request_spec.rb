require 'rails_helper'
require './spec/support/user_setup'

RSpec.describe 'User Sessions', :vcr do
  include_context 'user_setup'
  
  describe 'POST /sessions' do
    it 'logs in a user' do
      expect(response).to be_successful

      login_params = { email: 'joel@plantcoach.com', password: '12345' }
      post '/api/v1/sessions', params: login_params
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(result[:user][:data][:attributes][:name]).to eq('Joel Grant')
    end

    it 'returns a status 201 for a "create" session' do
      login_params = { email: 'joel@plantcoach.com', password: '12345' }
      post '/api/v1/sessions', params: login_params

      expect(response.status).to eq(201)
    end

    it 'creates a JWT to maintain a user session and for user requests' do
      expect(response).to be_successful

      login_params = { email: 'joel@plantcoach.com', password: '12345' }
      post '/api/v1/sessions', params: login_params

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:jwt]).to_not be nil
    end

    it 'returns an error if the password is bad' do
      expect(response).to be_successful

      login_params = { email: 'joel@plantcoach.com', password: 'WRONG PASSWORD' }
      post '/api/v1/sessions', params: login_params

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(401)
      expect(result[:error]).to eq('Your credentials are incorrect!')
    end

    it 'returns an error if the user doesnt exist' do
      expect(response).to be_successful

      non_existent_user = { email: 'joe12345@shmo.com', password: 'ABCDE' }
      post '/api/v1/sessions', params: non_existent_user

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(401)
      expect(result[:error]).to eq('Your credentials are incorrect!')
    end
  end

  describe 'DELETE /sessions' do
    it 'logs out the user' do
      login_params = { email: 'joel@plantcoach.com', password: '12345' }
      post '/api/v1/sessions', params: login_params
      result = JSON.parse(response.body, symbolize_names: true)

      delete "/api/v1/sessions/#{result[:user][:data][:id]}", headers: {
        Authorization: "Bearer #{result[:jwt]}"
      }

      expect(response.status).to eq(204)
    end

    it 'destroys the user session from being used' do
      login_params = { email: 'joel@plantcoach.com', password: '12345' }
      post '/api/v1/sessions', params: login_params
      result = JSON.parse(response.body, symbolize_names: true)

      delete "/api/v1/sessions/#{result[:user][:data][:id]}", headers: {
        Authorization: "Bearer #{result[:jwt]}"
      }

      expect(response.status).to eq(204)

      post '/api/v1/plants', params: plant5_params

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(401)
      expect(result[:message]).to eq('Please log in')

      get '/api/v1/plants'

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(401)
      expect(result[:message]).to eq('Please log in')
    end
  end
end
