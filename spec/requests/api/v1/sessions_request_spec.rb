require 'rails_helper'

RSpec.describe 'User Sessions', :vcr do

  before(:each) do
    post '/api/v1/users', params: body
  end

  let(:body) { { name: 'Joel Grant', email: 'joel@plantcoach.com',
    zip_code: '80121', password: '12345', password_confirmation: '12345' } }

  let(:user_response) { JSON.parse(response.body, symbolize_names: true) }

  describe 'POST /sessions' do
    it 'logs in a user' do
      expect(response).to be_successful

      login_params = { email: 'joel@plantcoach.com', password: '12345' }
      post '/api/v1/sessions', params: login_params
      
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(result[:user][:data][:attributes][:name]).to eq("Joel Grant")
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
      expect(result[:error]).to eq("Your credentials are incorrect!")
    end

    it 'returns an error if the user doesnt exist' do
      expect(response).to be_successful

      non_existent_user = {email: 'joe12345@shmo.com', password: 'ABCDE'}
      post '/api/v1/sessions', params: non_existent_user

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(401)
      expect(result[:error]).to eq("Your credentials are incorrect!")
    end
  end
end
