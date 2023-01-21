require 'rails_helper'

RSpec.describe 'StartedIndoorSeeds API Endpoints' do
  before(:each) do
    tomato_seed = SeedDefaultData.create!(
      plant_type: "Tomato",
      days_to_maturity: 55,
      seedling_days_to_transplant: 49,
      days_relative_to_frost_date: 14,
      direct_seed: false
    )
    pepper_seed = SeedDefaultData.create!(
      plant_type: "Pepper",
      days_to_maturity: 64,
      seedling_days_to_transplant: 54,
      days_relative_to_frost_date: 14,
      direct_seed: false
    )
    eggplant_seed = SeedDefaultData.create!(
      plant_type: "Eggplant",
      days_to_maturity: 68,
      seedling_days_to_transplant: 52,
      days_relative_to_frost_date: 14,
      direct_seed: false
    )
    romaine_seed = SeedDefaultData.create(
      plant_type: "Romaine Lettuce",
      days_to_maturity: 35,
      seedling_days_to_transplant: 14,
      days_relative_to_frost_date: -28,
      direct_seed: true
    )
    green_bean_seed = SeedDefaultData.create(
      plant_type: "Green Bean",
      days_to_maturity: 52,
      seedling_days_to_transplant: 14,
      days_relative_to_frost_date: 0,
      direct_seed: true
    )
  end

  describe 'GET /started_indoor_seeds' do
    it 'gets all the plants in the users garden that have also been started inside and not yet transplanted outdoors' do
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
      # While a function of the app is to auto-provide missing attributes of a
      # new plant, that does not seem to work quickly enough while RSpec is running tests.
      # Therefore, they need to be explicitly assigned as this causes validation errors.
      # It is also not the purpose of this test.
      plant = user.plants.create!(
        name: "Sungold",
        plant_type: "Tomato",
        days_relative_to_frost_date: 14,
        days_to_maturity: 60,
        hybrid_status: 1
      )
      plant1 = user.plants.create!(
        name: "Jalafuego",
        plant_type: "Pepper",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: 1
      )
      plant2 = user.plants.create!(
        name: "Rosa Bianca",
        plant_type: "Eggplant",
        days_relative_to_frost_date: 14,
        days_to_maturity: 70,
        hybrid_status: 1
      )

      post '/api/v1/garden_plants', params: { plant_id: plant.id, start_from_seed: :yes, sewing_date: Date.yesterday }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
      }

      post '/api/v1/garden_plants', params: { plant_id: plant1.id, start_from_seed: :yes, sewing_date: Date.yesterday }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
      }

      post '/api/v1/garden_plants', params: { plant_id: plant2.id, start_from_seed: :yes, sewing_date: Date.yesterday }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
      }

      get '/api/v1/started_indoor_seeds', headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
        }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data].count).to eq(3)

      result[:data].each do |plant|
        expect(plant[:attributes][:actual_transplant_date]).to be nil
        expect(plant[:attributes][:direct_seed]).to be false
        expect(plant[:attributes][:planting_status]).to eq "started"
        expect(plant[:attributes][:start_from_seed]).to be true
      end
    end

    it 'does not get any plants that have not been started' do
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

      # While a function of the app is to auto-provide missing attributes of a
      # new plant, that does not seem to work quickly enough while RSpec is running tests.
      # Therefore, they need to be explicitly assigned as this causes validation errors.
      # It is also not the purpose of this test.
      plant = user.plants.create!(
        name: "Sungold",
        plant_type: "Tomato",
        days_relative_to_frost_date: 14,
        days_to_maturity: 60,
        hybrid_status: 1
      )
      plant1 = user.plants.create!(
        name: "Jalafuego",
        plant_type: "Pepper",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: 1
      )
      plant2 = user.plants.create!(
        name: "Rosa Bianca",
        plant_type: "Eggplant",
        days_relative_to_frost_date: 14,
        days_to_maturity: 70,
        hybrid_status: 1
      )
      plant3 = user.plants.create!(
        name: "Coastal Star",
        plant_type: "Romaine Lettuce",
        days_relative_to_frost_date: -45,
        days_to_maturity: 30,
        hybrid_status: 1
      )

      post '/api/v1/garden_plants', params: { plant_id: plant.id, start_from_seed: :yes, sewing_date: Date.yesterday }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
      }

      post '/api/v1/garden_plants', params: { plant_id: plant1.id, start_from_seed: :yes, sewing_date: Date.yesterday }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
      }

      post '/api/v1/garden_plants', params: { plant_id: plant2.id, start_from_seed: :yes, sewing_date: Date.yesterday }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
      }

      post '/api/v1/garden_plants', params: { plant_id: plant3.id, start_from_seed: :yes, sewing_date: Date.yesterday }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
      }

      get '/api/v1/started_indoor_seeds', headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
        }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data].count).to eq(3)

      result[:data].each do |plant|
        expect(plant[:attributes][:plant_type]).to_not eq("Romaine Lettuce")
        expect(plant[:attributes][:direct_seed]).to_not be true
        expect(plant[:attributes][:planting_status]).to_not eq("not started")
        expect(plant[:attributes][:start_from_seed]).to_not be false


        expect(plant[:attributes][:actual_transplant_date]).to be nil
        expect(plant[:attributes][:direct_seed]).to be false
        expect(plant[:attributes][:planting_status]).to eq "started"
        expect(plant[:attributes][:start_from_seed]).to be true
      end
    end

    it 'will not include plants that are waiting to be planted' do
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

      # While a function of the app is to auto-provide missing attributes of a
      # new plant, that does not seem to work quickly enough while RSpec is running tests.
      # Therefore, they need to be explicitly assigned as this causes validation errors.
      # It is also not the purpose of this test.
      plant = user.plants.create!(
        name: "Sungold",
        plant_type: "Tomato",
        days_relative_to_frost_date: 14,
        days_to_maturity: 60,
        hybrid_status: 1
      )
      plant1 = user.plants.create!(
        name: "Jalafuego",
        plant_type: "Pepper",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: 1
      )
      plant2 = user.plants.create!(
        name: "Rosa Bianca",
        plant_type: "Eggplant",
        days_relative_to_frost_date: 14,
        days_to_maturity: 70,
        hybrid_status: 1
      )
      plant3 = user.plants.create!(
        name: "Coastal Star",
        plant_type: "Romaine Lettuce",
        days_relative_to_frost_date: -45,
        days_to_maturity: 30,
        hybrid_status: 1
      )

      post '/api/v1/garden_plants', params: { plant_id: plant.id, start_from_seed: :yes, sewing_date: Date.yesterday }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
      }

      post '/api/v1/garden_plants', params: { plant_id: plant1.id, start_from_seed: :yes, sewing_date: Date.yesterday }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
      }

      post '/api/v1/garden_plants', params: { plant_id: plant2.id, start_from_seed: :yes, sewing_date: nil }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
      }

      post '/api/v1/garden_plants', params: { plant_id: plant3.id, start_from_seed: :yes, sewing_date: Date.yesterday }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
      }

      get '/api/v1/started_indoor_seeds', headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
        }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data].count).to eq(2)

      result[:data].each do |plant|
        expect(plant[:attributes][:plant_type]).to_not eq("Eggplant")

        expect(plant[:attributes][:actual_transplant_date]).to be nil
        expect(plant[:attributes][:direct_seed]).to be false
        expect(plant[:attributes][:planting_status]).to eq "started"
        expect(plant[:attributes][:start_from_seed]).to be true
      end
    end

    it 'will not include plants that have been transplanted outdoors' do
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

      # While a function of the app is to auto-provide missing attributes of a
      # new plant, that does not seem to work quickly enough while RSpec is running tests.
      # Therefore, they need to be explicitly assigned as this causes validation errors.
      # It is also not the purpose of this test.
      plant = user.plants.create!(
        name: "Sungold",
        plant_type: "Tomato",
        days_relative_to_frost_date: 14,
        days_to_maturity: 60,
        hybrid_status: 1
      )
      plant1 = user.plants.create!(
        name: "Jalafuego",
        plant_type: "Pepper",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: 1
      )
      plant2 = user.plants.create!(
        name: "Rosa Bianca",
        plant_type: "Eggplant",
        days_relative_to_frost_date: 14,
        days_to_maturity: 70,
        hybrid_status: 1
      )
      plant3 = user.plants.create!(
        name: "Coastal Star",
        plant_type: "Romaine Lettuce",
        days_relative_to_frost_date: -45,
        days_to_maturity: 30,
        hybrid_status: 1
      )

      post '/api/v1/garden_plants', params: { plant_id: plant.id, start_from_seed: :yes, sewing_date: Date.yesterday }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
      }

      post '/api/v1/garden_plants', params: { plant_id: plant1.id, start_from_seed: :yes, sewing_date: Date.yesterday }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
      }

      post '/api/v1/garden_plants', params: { plant_id: plant2.id, start_from_seed: :yes, sewing_date: Date.yesterday }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
      }

      last_garden_plant = GardenPlant.last

      patch "/api/v1/garden_plants/#{last_garden_plant.id}", params: { actual_transplant_date: Date.today }, headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }

      get '/api/v1/started_indoor_seeds', headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
        }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data].count).to eq(2)

      result[:data].each do |plant|
        expect(plant[:attributes][:plant_type]).to_not eq("Eggplant")

        expect(plant[:attributes][:actual_transplant_date]).to be nil
        expect(plant[:attributes][:direct_seed]).to be false
        expect(plant[:attributes][:planting_status]).to eq "started"
        expect(plant[:attributes][:start_from_seed]).to be true
      end
    end

    it 'will not include plants that are direct-sewn' do
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

      # While a function of the app is to auto-provide missing attributes of a
      # new plant, that does not seem to work quickly enough while RSpec is running tests.
      # Therefore, they need to be explicitly assigned as this causes validation errors.
      # It is also not the purpose of this test.
      plant = user.plants.create!(
        name: "Sungold",
        plant_type: "Tomato",
        days_relative_to_frost_date: 14,
        days_to_maturity: 60,
        hybrid_status: 1
      )
      plant1 = user.plants.create!(
        name: "Jalafuego",
        plant_type: "Pepper",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: 1
      )
      plant2 = user.plants.create!(
        name: "Rosa Bianca",
        plant_type: "Eggplant",
        days_relative_to_frost_date: 14,
        days_to_maturity: 70,
        hybrid_status: 1
      )
      plant3 = user.plants.create!(
        name: "Coastal Star",
        plant_type: "Romaine Lettuce",
        days_relative_to_frost_date: -45,
        days_to_maturity: 30,
        hybrid_status: 1
      )
      
      post '/api/v1/garden_plants', params: { plant_id: plant.id, start_from_seed: :yes, sewing_date: Date.yesterday }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
      }

      post '/api/v1/garden_plants', params: { plant_id: plant1.id, start_from_seed: :yes, sewing_date: Date.yesterday }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
      }

      post '/api/v1/garden_plants', params: { plant_id: plant2.id, start_from_seed: :yes, sewing_date: Date.yesterday }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
      }

      last_garden_plant = GardenPlant.last

      patch "/api/v1/garden_plants/#{last_garden_plant.id}", params: { actual_transplant_date: Date.today }, headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }

      get '/api/v1/started_indoor_seeds', headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
        }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data].count).to eq(2)

      result[:data].each do |plant|
        expect(plant[:attributes][:plant_type]).to_not eq("Romaine Lettuce")

        expect(plant[:attributes][:actual_transplant_date]).to be nil
        expect(plant[:attributes][:direct_seed]).to be false
        expect(plant[:attributes][:planting_status]).to eq "started"
        expect(plant[:attributes][:start_from_seed]).to be true
      end
    end
  end
end
