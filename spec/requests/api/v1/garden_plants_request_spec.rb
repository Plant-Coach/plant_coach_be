require 'rails_helper'

RSpec.describe 'Garden Plants API Endpoint' do
  describe 'POST garden plants' do
    it 'creates new plant that the user will be planting' do
      tomato_seed = SeedDefaultData.create(
        plant_type: "Tomato",
        days_to_maturity: 55,
        seedling_days_to_transplant: 49,
        days_relative_to_frost_date: 14,
        direct_seed: :no
      )
      pepper_seed = SeedDefaultData.create(
        plant_type: "Pepper",
        days_to_maturity: 64,
        seedling_days_to_transplant: 49,
        days_relative_to_frost_date: 14,
        direct_seed: :no
      )
      eggplant_seed = SeedDefaultData.create(
        plant_type: "Eggplant",
        days_to_maturity: 68,
        seedling_days_to_transplant: 49,
        days_relative_to_frost_date: 14,
        direct_seed: :no
      )
      body = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body
      user_response = JSON.parse(response.body, symbolize_names: true)
      user = User.find_by_id(user_response[:user][:data][:id])
      plant = user.plants.create!(
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: 1,
        organic: false
      )

      post '/api/v1/garden_plants', params: { plant_id: plant.id, start_from_seed: :yes, sewing_date: Date.today }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
        }
      result = JSON.parse(response.body, symbolize_names: true)
      new_plant = GardenPlant.last

      expect(response).to be_successful

      expect(new_plant.id).to eq(result[:data][:id].to_i)

      expect(result).to be_a Hash
      expect(result).to have_key(:data)

      expect(result[:data]).to be_a Hash
      expect(result[:data][:attributes][:name]).to eq(new_plant.name)

      expect(result[:data][:attributes]).to have_key(:name)
      expect(result[:data][:attributes]).to have_key(:plant_type)
      expect(result[:data][:attributes]).to have_key(:days_relative_to_frost_date)
      expect(result[:data][:attributes]).to have_key(:recommended_transplant_date)
      expect(result[:data][:attributes]).to have_key(:days_to_maturity)
      expect(result[:data][:attributes]).to have_key(:hybrid_status)
      expect(result[:data][:attributes]).to have_key(:organic)
      expect(result[:data][:attributes]).to have_key(:planting_status)
      expect(result[:data][:attributes]).to have_key(:start_from_seed)
      expect(result[:data][:attributes]).to have_key(:direct_seed)
      expect(result[:data][:attributes]).to have_key(:recommended_seed_sewing_date)
      expect(result[:data][:attributes]).to have_key(:actual_seed_sewing_date)
      expect(result[:data][:attributes]).to have_key(:seedling_days_to_transplant)
    end
    #likely to delete
    xit 'will return a json error message if there was a problem' do
      body = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body
      user_response = JSON.parse(response.body, symbolize_names: true)

      user = User.find_by_id(user_response[:user][:data][:id])
      plant = user.plants.create!(
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: 1,
        organic: false
      )

      post '/api/v1/garden_plants', params: { plant_id: 99999999999}, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
        }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)
    end
  end

  describe 'GET /garden_plants' do
    xit 'retrieves an array of the plants that belong to the user' do
      user_data = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: user_data
      user_response = JSON.parse(response.body, symbolize_names: true)

      user = User.find_by_id(user_response[:user][:data][:id])
      plant1 = user.plants.create!(
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: 1,
        organic: false
      )
      plant2 = user.plants.create!(
        plant_type: "Pepper",
        name: "Jalafuego",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: 1,
        organic: false
      )
      unused_plant = user.plants.create!(
        plant_type: "Something else",
        name: "A plant you shouldn't see",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: 1,
        organic: false
      )
      user.garden_plants.create!(
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: 1,
        organic: false
      )
      user.garden_plants.create!(
        plant_type: "Pepper",
        name: "Jalafuego",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: 1,
        organic: false
      )

      get '/api/v1/garden_plants', headers: {
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
        expect(plant[:attributes][:hybrid_status]).to eq("f1").or eq("open_pollinated")
      end
    end
  end

  describe 'PATCH /garden_plants' do
    it 'allows the user to add an actual planting date to an existing garden_plant which also updates the planting status' do
      tomato_seed = SeedDefaultData.create(
        plant_type: "Tomato",
        days_to_maturity: 55,
        seedling_days_to_transplant: 49,
        days_relative_to_frost_date: 14,
        direct_seed: :no
      )
      user_data = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: user_data
      user_response = JSON.parse(response.body, symbolize_names: true)

      user = User.find_by_id(user_response[:user][:data][:id])
      plant = user.plants.create!(
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: 1,
        organic: false
      )

      post '/api/v1/garden_plants', params: { plant_id: plant.id, start_from_seed: :yes, sewing_date: nil }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
        }

      result = JSON.parse(response.body, symbolize_names: true)
      garden_plant = GardenPlant.last

      expect(response).to be_successful

      expect(garden_plant.id).to eq(result[:data][:id].to_i)

      expect(result).to be_a Hash
      expect(result).to have_key(:data)

      expect(result[:data]).to be_a Hash
      expect(result[:data][:attributes][:name]).to eq(garden_plant.name)

      expect(result[:data][:attributes]).to have_key(:name)
      expect(result[:data][:attributes]).to have_key(:plant_type)
      expect(result[:data][:attributes]).to have_key(:days_relative_to_frost_date)
      expect(result[:data][:attributes]).to have_key(:recommended_transplant_date)
      expect(result[:data][:attributes]).to have_key(:days_to_maturity)
      expect(result[:data][:attributes]).to have_key(:hybrid_status)
      expect(result[:data][:attributes]).to have_key(:organic)
      expect(result[:data][:attributes]).to have_key(:planting_status)
      expect(result[:data][:attributes]).to have_key(:start_from_seed)
      expect(result[:data][:attributes]).to have_key(:direct_seed)
      expect(result[:data][:attributes]).to have_key(:recommended_seed_sewing_date)
      expect(result[:data][:attributes]).to have_key(:actual_seed_sewing_date)
      expect(result[:data][:attributes]).to have_key(:seedling_days_to_transplant)

      patch "/api/v1/garden_plants/#{garden_plant.id}", params: { actual_seed_sewing_date: Date.yesterday }

      patch_result = JSON.parse(response.body, symbolize_names: true)
      require 'pry'; binding.pry
    end
  end

  describe 'DELETE /garden_plants' do
    xit 'removes the plant from the users list of plants' do
      body = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body
      user_response = JSON.parse(response.body, symbolize_names: true)

      user = User.find_by_id(user_response[:user][:data][:id])
      plant = user.plants.create!(
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: 1,
        organic: false
      )
      # require 'pry'; binding.pry
      garden_plant = user.garden_plants.create!(
          plant_type: "Tomato",
          name: "Sungold",
          days_relative_to_frost_date: 14,
          days_to_maturity: 54,
          hybrid_status: 1,
          organic: false,
          direct_seed: true,

      )
      # Would like to refactor this to use params hash.
      delete "/api/v1/garden_plants/#{garden_plant.id}", headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:status]).to eq("success")
    end
  end
end
