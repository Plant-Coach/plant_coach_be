require 'rails_helper'

RSpec.describe 'Plant API Endpoints' do
  describe 'GET /plants' do
    it 'retrieves all the plants that have been added to the application' do
      body = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      plant1 = {
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: 1
      }
      plant2 = {
        plant_type: "Pepper",
        name: "Round of Hungary",
        days_relative_to_frost_date: 14,
        days_to_maturity: 60,
        hybrid_status: 1
      }
      plant3 = {
        plant_type: "Eggplant",
        name: "Rosa Bianca",
        days_relative_to_frost_date: 14,
        days_to_maturity: 68,
        hybrid_status: 1
      }
      plant4 = {
        plant_type: "Romaine Lettuce",
        name: "Costal Star",
        days_relative_to_frost_date: 30,
        days_to_maturity: 25,
        hybrid_status: 1
      }
      post '/api/v1/plants', params: plant1, headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }
      # require 'pry'; binding.pry
      post '/api/v1/plants', params: plant2, headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }
      # require 'pry'; binding.pry
      post '/api/v1/plants', params: plant3, headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }
      # require 'pry'; binding.pry
      post '/api/v1/plants', params: plant4, headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }

      get '/api/v1/plants', headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a Hash
      expect(data[:data]).to be_an Array
      expect(data[:data].count).to eq(4)

      data[:data].each do |plant|
        expect(plant).to have_key(:id)
        expect(plant[:id]).to be_a String

        expect(plant).to have_key(:type)
        expect(plant[:type]).to be_a String
        expect(plant[:type]).to eq("plant")

        expect(plant[:attributes]).to be_a Hash

        expect(plant[:attributes]).to have_key(:plant_type)
        expect(plant[:attributes][:plant_type]).to be_a String

        expect(plant[:attributes]).to have_key(:name)
        expect(plant[:attributes][:name]).to be_a String

        expect(plant[:attributes]).to have_key(:days_relative_to_frost_date)
        expect(plant[:attributes][:days_relative_to_frost_date]).to be_an Integer

        expect(plant[:attributes]).to have_key(:days_to_maturity)
        expect(plant[:attributes][:days_to_maturity]).to be_an Integer

        expect(plant[:attributes]).to have_key(:hybrid_status)
        expect(plant[:attributes][:hybrid_status]).to be_an Integer
      end
    end
  end

  describe 'POST /plants' do
    it 'creates a new plant in the database' do
      body = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      plant = {
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: 1}
      post '/api/v1/plants', params: plant, headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(result).to be_a Hash
      expect(result[:data][:attributes][:name]).to eq("Sungold")
    end
  end

  describe 'PATCH /plants' do
    it 'updates an existing plant with new attributes' do
      body = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      plant = Plant.create(
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: 1)
      patch "/api/v1/plants/#{plant.id}", params: {
        days_to_maturity: 61
        }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
        }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][0][:attributes][:days_to_maturity]).to eq(61)
    end
  end

  describe 'DELETE /plants' do
    it 'removes a plant from the list of available plants' do
      body = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      plant1 = Plant.create(
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: 1
      )
      plant2 = Plant.create(
        plant_type: "Pepper",
        name: "Jalafuego",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: 1
      )
      plant3 = Plant.create(
        plant_type: "Radish",
        name: "French Breakfast",
        days_relative_to_frost_date: 30,
        days_to_maturity: 21,
        hybrid_status: 1
      )

      delete "/api/v1/plants/#{plant3.id}", headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(Plant.find_by(id: plant3.id)).to be nil
    end

    it 'returns an error if the plant cant be found' do
      body = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      plant1 = Plant.create(
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: 1
      )
      plant2 = Plant.create(
        plant_type: "Pepper",
        name: "Jalafuego",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: 1
      )
      plant3 = Plant.create(
        plant_type: "Radish",
        name: "French Breakfast",
        days_relative_to_frost_date: 30,
        days_to_maturity: 21,
        hybrid_status: 1
      )
      delete "/api/v1/plants/999999", headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:error]).to eq("Something happened!")
    end
  end
end
