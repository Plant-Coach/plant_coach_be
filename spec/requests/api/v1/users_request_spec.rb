require 'rails_helper'

RSpec.describe 'Users API' do
  describe 'POST user' do
    it 'creates a new user' do
      body = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body
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

    it 'will not allow duplicate users to be created' do
      body = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body

      # Try to create the same user a second time.
      post '/api/v1/users', params: body
      expected_error = JSON.parse(response.body, symbolize_names: true)

      expect(expected_error[:error]).to eq("This user already exists!!")
    end

    it 'will not allow a user to register with unmatching passwords' do
      body = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80000',
        password: '123457',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(result[:error]).to eq("Your passwords must match!")
    end

    it 'doesnt allow anything other than an email address for a new user' do
      body = {
        name: 'Joel Grant',
        email: 'joe.com',
        zip_code: '12345',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:error]).to eq("#{body[:email]} is not a valid email address!!")
    end
  end

  describe 'PATCH user' do
    it 'allows a user and its attributes to be edited' do
      user = User.create!(
        name: "Joel User",
        email: 'joel@123.com',
        password: "12345",
        zip_code: 80123
      )
      new_zip_code =  { zip_code: 80111 }

      patch "/api/v1/users/#{user.id}", params: new_zip_code
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:id]).to eq("#{user.id}")
      expect(result[:data][:attributes][:zip_code]).to eq("80111")
      expect(result[:data][:attributes][:name]).to eq("Joel User")
      expect(result[:data][:attributes][:email]).to eq("joel@123.com")
    end

    it 'will return an error in JSON if the user doesnt exist' do
      user = User.create!(
        name: "Joel User",
        email: 'joel@123.com',
        password: "12345",
        zip_code: 80123
      )
      new_zip_code =  { zip_code: 80111 }

      patch "/api/v1/users/9999999999", params: new_zip_code
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:error]).to eq("User not found!!")
    end
  end

  describe 'GET users' do
    it 'allows searching for a user by email' do
      user = User.create!(
        name: "Joel User",
        email: 'joel@123.com',
        password: "12345",
        zip_code: 80123
      )
      get '/api/v1/users', params: { email: "joel@123.com" }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:id]).to eq("#{user.id}")
      expect(result[:data][:attributes][:zip_code]).to eq("80123")
      expect(result[:data][:attributes][:name]).to eq("Joel User")
      expect(result[:data][:attributes][:email]).to eq("joel@123.com")
    end

    it 'will return an error in JSON if the user doesnt exist' do
      user = User.create!(
        name: "Joel User",
        email: 'joel@123.com',
        password: "12345",
        zip_code: 80123
      )
      new_zip_code =  { zip_code: 80111 }

      get "/api/v1/users", params: { email: "joel@wrongemail.com" }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:error]).to eq("This user is not found!")
    end
  end
end
