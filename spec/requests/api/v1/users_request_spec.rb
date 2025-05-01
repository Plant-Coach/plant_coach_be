require 'rails_helper'
require 'rake'

RSpec.describe 'Users API', :vcr do
  let(:body) do
    {
      name: 'Joel Grant',
      email: 'joel@plantcoach.com',
      zip_code: '80121',
      password: '12345',
      password_confirmation: '12345'
    }
  end

  before(:each) do
    PlantGuideMaster.create!(plant_type: 'Tomato', seedling_days_to_transplant: 56, days_to_maturity: 65,
                             days_relative_to_frost_date: 14, harvest_period: 'season_long', direct_seed_recommended: false)
    post '/api/v1/users', params: body
  end

  describe 'POST /users' do
    it 'creates a new user' do
      User.last

      expect(response).to be_successful

      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(user_response).to be_a Hash

      expect(user_response).to have_key(:user)
      expect(user_response[:user]).to have_key(:data)
      expect(user_response[:user][:data]).to have_key(:id)

      expect(user_response[:user][:data]).to have_key(:type)
      expect(user_response[:user][:data][:type]).to be_a String
      expect(user_response[:user][:data][:type]).to eq('user')

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
      JSON.parse(response.body, symbolize_names: true)
    end

    it 'does not allow duplicate users to be created' do
      # A second attempt to create the same user should be unsuccessful.
      post '/api/v1/users', params: body
      expected_error = JSON.parse(response.body, symbolize_names: true)

      expect(expected_error[:error]).to eq('This user already exists!!')
    end

    it 'does not allow a user to register with mismatching passwords' do
      body_with_password_mismatch = {
        name: 'Joel Grant',
        email: 'joel@mismatch.com',
        zip_code: '80000',
        password: '123457',
        password_confirmation: '12345'
      }

      post '/api/v1/users', params: body_with_password_mismatch
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(result[:error]).to eq('Your passwords must match!')
    end

    it 'requires that a properly formatted email address be used for registration' do
      user_params_with_incorrectly_formatted_email = {
        name: 'Joel Grant',
        email: 'joe.com',
        zip_code: '12345',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: user_params_with_incorrectly_formatted_email
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:error])
        .to eq("#{user_params_with_incorrectly_formatted_email[:email]} is not a valid email address!!")
    end

    it 'requires the users name' do
      user_params_with_missing_name = {
        email: 'joel@plants.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: user_params_with_missing_name
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:error]).to eq("The user's name must not be blank!")
    end

    it 'givest the user some pre-loaded plant guides to get them started' do
      expect(User.last.plant_guides.count).to eq(1)
    end
  end

  describe 'PATCH /users' do
    it 'allows a User and their attributes to be edited' do
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      new_zip_code = { zip_code: 80_111 }

      patch "/api/v1/users/#{user_response[:user][:data][:id]}", params: new_zip_code, headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:attributes][:zip_code]).to eq('80111')
      expect(result[:data][:attributes][:name]).to eq('Joel Grant')
      expect(result[:data][:attributes][:email]).to eq('joel@plantcoach.com')
    end

    # Test skipped as this scenario is not actually possible after a recent refactor because
    # the app does not rely on the User's ID to come from the params, but is already in the cookie.
    xit 'will return an error if the user doesnt exist' do
      JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      new_zip_code = { zip_code: 80_111 }
      patch '/api/v1/users/9999999999', params: new_zip_code

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:error]).to eq('User not found!!')
    end

    it 'will update the frost dates to the users new zip code' do
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      new_zip_code = { zip_code: 99_501 }

      patch "/api/v1/users/#{user_response[:user][:data][:id]}", params: new_zip_code, headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:attributes][:zip_code]).to eq('99501')
      expect(result[:data][:attributes][:name]).to eq('Joel Grant')
      expect(result[:data][:attributes][:email]).to eq('joel@plantcoach.com')
      expect(result[:data][:attributes][:spring_frost_date]).to_not eq(user_response[:user][:data][:attributes][:spring_frost_date])
      expect(result[:data][:attributes][:fall_frost_date]).to_not eq(user_response[:user][:data][:attributes][:fall_frost_date])
    end

    it 'will not allow a user to save an empty attribute' do
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      updated_user_params_with_missing_name = {
        name: ''
      }

      patch "/api/v1/users/#{user_response[:user][:data][:id]}", params: updated_user_params_with_missing_name, headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:error]).to eq("The user's name must not be blank!")
      expect(result[:user][:name]).to eq('Joel Grant')
    end
  end

  describe 'GET /users' do
    it 'returns the user that is identified by the Session Cookie' do
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      get '/api/v1/users', headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)
      last_user = User.last

      expect(result).to be_a Hash
      expect(result[:data]).to be_a Hash
      expect(result[:data]).to have_key(:attributes)
      expect(result[:data][:attributes]).to have_key(:id)
      expect(result[:data][:attributes][:id]).to eq(last_user.id)
      expect(result[:data][:attributes]).to have_key(:name)
      expect(result[:data][:attributes]).to have_key(:email)
      expect(result[:data][:attributes]).to have_key(:zip_code)
    end

    it 'will not return anything if a JWT is not provided' do
      JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      get '/api/v1/users'
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a Hash
      expect(result[:message]).to eq('Please log in')
    end
  end

  describe 'DELETE /users' do
    it 'deletes the users account' do
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
