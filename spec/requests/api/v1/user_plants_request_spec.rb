require 'rails_helper'

RSpec.describe 'User Plants API Endpoint' do
  describe 'POST user plants' do
    it 'creates new plant that the user will be planting' do
      body = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body
      user_response = JSON.parse(response.body, symbolize_names: true)

      plant = Plant.create!(
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: 1
      )

      post '/api/v1/user_plants', params: { plant_id: plant.id }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
        }
      result = JSON.parse(response.body, symbolize_names: true)
      new_plant = UserPlant.last

      expect(response).to be_successful
      
      expect(new_plant.plant_id).to eq(plant.id)

      expect(result).to be_a Hash
      expect(result).to have_key(:data)

      expect(result[:data]).to be_a Hash
      expect(result[:data][:attributes][:name]).to eq(plant.name)
    end

    it 'will return a json error message if there was a problem' do
      body = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body
      user_response = JSON.parse(response.body, symbolize_names: true)

      plant = Plant.create!(
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: 1
      )

      post '/api/v1/user_plants', params: { plant_id: "Useless Data"}, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
        }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)
    end
  end

  describe 'GET /user_plants' do
    it 'retrieves an array of the plants that belong to the user' do
      user_data = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: user_data
      user_response = JSON.parse(response.body, symbolize_names: true)

      plant1 = Plant.create!(
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: 1
      )
      plant2 = Plant.create!(
        plant_type: "Pepper",
        name: "Jalafuego",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: 1
      )
      unused_plant = Plant.create!(
        plant_type: "Pepper",
        name: "Jalafuego",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: 1
      )
      UserPlant.create(
        user_id: user_response[:user][:data][:id],
        plant_id: plant1.id
      )
      UserPlant.create(
        user_id: user_response[:user][:data][:id],
        plant_id: plant2.id
      )

      get '/api/v1/user_plants', headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a Hash
      expect(result[:data]).to be_an Array

      #This makes sure the 'unused_plant' variable above is intentionally excluded
      expect(result[:data].count).to eq(2)

      result[:data].each do |plant|
        expect(plant[:attributes][:plant_type]).to be_a String
        expect(plant[:attributes][:name]).to be_a String
        expect(plant[:attributes][:days_relative_to_frost_date]).to be_an Integer
        expect(plant[:attributes][:days_to_maturity]).to be_an Integer
        expect(plant[:attributes][:hybrid_status]).to be_an Integer
      end
    end
  end

  describe 'DELETE /user_plants' do
    it 'removes the plant from the users list of plants' do
      body = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body
      user_response = JSON.parse(response.body, symbolize_names: true)

      plant = Plant.create!(
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: 1
      )
      user_plant = UserPlant.create(
        user_id: user_response[:user][:data][:id],
        plant_id: plant.id
      )
      # Would like to refactor this to use params hash.
      delete "/api/v1/user_plants/#{user_plant.id}", headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:status]).to eq("success")
    end
  end
end
