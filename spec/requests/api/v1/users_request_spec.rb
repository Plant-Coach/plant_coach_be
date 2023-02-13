require 'rails_helper'

RSpec.describe 'Users API', :vcr do

  let(:body) {{
    name: 'Joel Grant',
    email: 'joel@plantcoach.com',
    zip_code: '80121',
    password: '12345',
    password_confirmation: '12345'
  }}

  before(:each) do
    post '/api/v1/users', params: body
  end

  describe 'POST user' do
    it 'creates a new user' do
      created_user = User.last

      expect(response).to be_successful

      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(user_response).to be_a Hash

      expect(user_response).to have_key(:user)
      expect(user_response[:user]).to have_key(:data)
      expect(user_response[:user][:data]).to have_key(:id)

      expect(user_response[:user][:data]).to have_key(:type)
      expect(user_response[:user][:data][:type]).to be_a String
      expect(user_response[:user][:data][:type]).to eq("user")

      expect(user_response[:user][:data]).to have_key(:attributes)
      expect(user_response[:user][:data][:attributes]).to be_a Hash

      expect(user_response[:user][:data][:attributes]).to have_key(:name)
      expect(user_response[:user][:data][:attributes][:name]).to be_a String

      expect(user_response[:user][:data][:attributes]).to have_key(:email)
      expect(user_response[:user][:data][:attributes][:email]).to be_a String

      expect(user_response[:user][:data][:attributes]).to have_key(:zip_code)
      expect(user_response[:user][:data][:attributes][:zip_code]).to be_a String
    end

    it 'will create a JWT for secure API calls' do
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(user_response).to have_key(:jwt)
      expect(user_response[:jwt]).to be_a String
    end 

    it 'will not allow duplicate users to be created' do
      # A second attempt to create the same user should be unsuccessful.
      post '/api/v1/users', params: body
      expected_error = JSON.parse(response.body, symbolize_names: true)

      expect(expected_error[:error]).to eq("This user already exists!!")
    end

    it 'will not allow a user to register with unmatching passwords' do
      body_with_password_mismatch = {
        name: 'Joel Grant',
        email: 'joel_password_mismatch@plantcoach.com',
        zip_code: '80000',
        password: '123457',
        password_confirmation: '12345'
      }

      post '/api/v1/users', params: body_with_password_mismatch
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(result[:error]).to eq("Your passwords must match!")
    end

    it 'doesnt allow anything other than an email address for a new user' do
      body_with_incorrectly_formatted_email = {
        name: 'Joel Grant',
        email: 'joe.com',
        zip_code: '12345',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body_with_incorrectly_formatted_email
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:error])
      .to eq("#{body_with_incorrectly_formatted_email[:email]} is not a valid email address!!")
    end
  end

  describe 'PATCH user' do
    it 'allows a user and its attributes to be edited' do
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      new_zip_code =  { zip_code: 80111 }

      patch "/api/v1/users/#{user_response[:user][:data][:id]}",
      params: new_zip_code,
      headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:attributes][:zip_code]).to eq("80111")
      expect(result[:data][:attributes][:name]).to eq("Joel Grant")
      expect(result[:data][:attributes][:email]).to eq("joel@plantcoach.com")
    end

    it 'will return an error in JSON if the user doesnt exist' do
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      new_zip_code =  { zip_code: 80111 }
      patch "/api/v1/users/9999999999",
      params: new_zip_code,
      headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:error]).to eq("User not found!!")
    end
  end

  describe 'GET /users' do
    it 'returns the user that is identified by the JWT' do
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      get '/api/v1/users', headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a Hash
      expect(result[:data]).to be_a Hash
      expect(result[:data]).to have_key(:attributes)
      expect(result[:data][:attributes]).to have_key(:id)
      expect(result[:data][:attributes]).to have_key(:name)
      expect(result[:data][:attributes]).to have_key(:email)
      expect(result[:data][:attributes]).to have_key(:zip_code)
    end

    it 'will not return anything if a JWT is not provided' do
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      get '/api/v1/users'

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a Hash
      expect(result[:message]).to eq("Please log in")
    end 
  end

  describe 'DELETE /users' do
    it 'deletes the users account and associations' do
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      get '/api/v1/users', headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)

      delete "/api/v1/users/#{result[:data][:id]}", headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }

      expect(response.status).to be 204
    end
  end
end
