require 'rails_helper'

RSpec.describe 'Plants Waiting To Be Started API Endpoint' do
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

  describe 'GET /plants_waiting_to_be_started' do
    it 'returns all the plants that have been added to the users garden but have not been transplanted or seeded' do
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
        name: "Sungold"
      )
      plant1 = user.plants.create!(
        plant_type: "Pepper",
        name: "Jedi"
      )
      plant2 = user.plants.create!(
        plant_type: "Eggplant",
        name: "Rosa Bianca"
      )
      post '/api/v1/garden_plants', params: { plant_id: plant.id, start_from_seed: :yes, sewing_date: nil }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
      }

      post '/api/v1/garden_plants', params: { plant_id: plant1.id, start_from_seed: :yes, sewing_date: nil }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
      }

      post '/api/v1/garden_plants', params: { plant_id: plant2.id, start_from_seed: :yes, sewing_date: nil }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
      }

      get '/api/v1/plants_waiting_to_be_started', headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
        }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data].count).to eq(3)

      result[:data].each do |plant|
        expect(plant[:attributes][:actual_transplant_date]).to be nil
        expect(plant[:attributes][:direct_seed]).to be false
        expect(plant[:attributes][:planting_status]).to eq "not started"
        expect(plant[:attributes][:actual_seed_sewing_date]).to be nil
        expect(plant[:attributes][:start_from_seed]).to be true
      end
    end
  end
end
