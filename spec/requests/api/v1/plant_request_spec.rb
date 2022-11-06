require 'rails_helper'

RSpec.describe 'Plant API Endpoints' do
  before(:each) do
    tomato_seed = SeedDefaultData.create!(
      plant_type: "Tomato",
      days_to_maturity: 55,
      seedling_days_to_transplant: 49,
      days_relative_to_frost_date: 14,
      direct_seed: "no"
    )
    pepper_seed = SeedDefaultData.create!(
      plant_type: "Pepper",
      days_to_maturity: 64,
      seedling_days_to_transplant: 49,
      days_relative_to_frost_date: 14,
      direct_seed: "no"
    )
    eggplant_seed = SeedDefaultData.create!(
      plant_type: "Eggplant",
      days_to_maturity: 68,
      seedling_days_to_transplant: 49,
      days_relative_to_frost_date: 14,
      direct_seed: "no"
    )
    romaine_seed = SeedDefaultData.create(
      plant_type: "Romaine Lettuce",
      days_to_maturity: 35,
      seedling_days_to_transplant: 14,
      days_relative_to_frost_date: -28,
      direct_seed: "yes"
    )
    green_bean_seed = SeedDefaultData.create(
      plant_type: "Green Bean",
      days_to_maturity: 52,
      seedling_days_to_transplant: 14,
      days_relative_to_frost_date: 0,
      direct_seed: "yes"
    )
  end
  describe 'GET /plants' do
    it 'retrieves all the plants that have been added to the application by that user' do
      body = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body
      user_response = JSON.parse(response.body, symbolize_names: true)

      # Created to make sure user's plants don't show up for other users
      erroneous_user = {
        name: 'Bad User',
        email: 'bad@user.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }

      post '/api/v1/users', params: erroneous_user
      expect(response).to be_successful

      plant1 = {
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: :f1
      }
      plant2 = {
        plant_type: "Pepper",
        name: "Round of Hungary",
        days_relative_to_frost_date: 14,
        days_to_maturity: 60,
        hybrid_status: :f1
      }
      plant3 = {
        plant_type: "Eggplant",
        name: "Rosa Bianca",
        days_relative_to_frost_date: 14,
        days_to_maturity: 68,
        hybrid_status: :open_pollinated
      }
      plant4 = {
        plant_type: "Romaine Lettuce",
        name: "Costal Star",
        days_relative_to_frost_date: 30,
        days_to_maturity: 25,
        hybrid_status: :f1
      }
      plant5 = {
        plant_type: "Green Bean",
        name: "Provider",
        days_relative_to_frost_date: -7,
        days_to_maturity: 45,
        hybrid_status: :f1
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

      post '/api/v1/plants', params: plant5, headers: {
        Authorization: "Bearer #{erroneous_user[:jwt]}"
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
        expect(plant[:attributes][:hybrid_status]).to eq("f1").or eq("open_pollinated")
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
        hybrid_status: :f1
      }
      post '/api/v1/plants', params: plant, headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(result).to be_a Hash
      expect(result[:data][:attributes][:name]).to eq("Sungold")
    end

    it 'will create a plant with unknown as the hybrid status if it is not provided' do
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
        organic: true,
        days_to_maturity: 54
      }
      post '/api/v1/plants', params: plant, headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to_not have_key(:error)

      expect(response).to be_successful

      expect(result[:data][:attributes][:hybrid_status]).to eq("unknown")
    end

    it 'will create a new plant even if the organic status is not known' do
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
        hybrid_status: :f1
      }
      post '/api/v1/plants', params: plant, headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to_not have_key(:error)

      expect(response).to be_successful

      expect(result[:data][:attributes][:organic]).to eq(false)
    end

    it 'will replace information with default data that the user does not provide' do
      ActiveRecord::Base.skip_callbacks = false
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
      }
      post '/api/v1/plants', params: plant, headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(201)
      expect(result).to be_a Hash
      expect(result[:data][:attributes][:name]).to eq("Sungold")
      expect(result[:data][:attributes][:days_to_maturity]).to eq(55)
      expect(result[:data][:attributes][:days_relative_to_frost_date]).to eq(14)
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
      user = User.last
      plant = user.plants.create!(
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: :f1
      )
      patch "/api/v1/plants/#{plant.id}", params: {
        days_to_maturity: 61
        }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
        }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:attributes][:days_to_maturity]).to eq(61)
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
      user = User.last
      plant1 = user.plants.create!(
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: :f1
      )
      plant2 = user.plants.create!(
        plant_type: "Pepper",
        name: "Jalafuego",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: :f1
      )
      plant3 = user.plants.create!(
        plant_type: "Radish",
        name: "French Breakfast",
        days_relative_to_frost_date: 30,
        days_to_maturity: 21,
        hybrid_status: :f1
      )

      delete "/api/v1/plants/#{plant3.id}", headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(Plant.find_by(id: plant3.id)).to be nil
    end

    it 'returns an error if the plant can not be found' do
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
      user = User.last
      plant1 = user.plants.create!(
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: :f1
      )
      plant2 = user.plants.create!(
        plant_type: "Pepper",
        name: "Jalafuego",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: :f1
      )
      plant3 = user.plants.create!(
        plant_type: "Radish",
        name: "French Breakfast",
        days_relative_to_frost_date: 30,
        days_to_maturity: 21,
        hybrid_status: :f1
      )
      delete "/api/v1/plants/999999", headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:error]).to eq("Something happened!")
    end
  end
end
