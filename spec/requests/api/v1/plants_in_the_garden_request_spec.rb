require 'rails_helper'

RSpec.describe 'Plants In The Garden API Endpoint', :vcr do
  before(:each) do
    tomato_seed = SeedDefaultData.create!(
      plant_type: "Tomato",
      days_to_maturity: 55,
      seedling_days_to_transplant: 49,
      days_relative_to_frost_date: 14,
      direct_seed_recommendation: :no
    )
    pepper_seed = SeedDefaultData.create!(
      plant_type: "Pepper",
      days_to_maturity: 64,
      seedling_days_to_transplant: 54,
      days_relative_to_frost_date: 14,
      direct_seed_recommendation: :no
    )
    eggplant_seed = SeedDefaultData.create!(
      plant_type: "Eggplant",
      days_to_maturity: 68,
      seedling_days_to_transplant: 52,
      days_relative_to_frost_date: 14,
      direct_seed_recommendation: :no
    )
    romaine_seed = SeedDefaultData.create(
      plant_type: "Romaine Lettuce",
      days_to_maturity: 35,
      seedling_days_to_transplant: 14,
      days_relative_to_frost_date: -28,
      direct_seed_recommendation: :yes
    )
    green_bean_seed = SeedDefaultData.create(
      plant_type: "Green Bean",
      days_to_maturity: 52,
      seedling_days_to_transplant: 14,
      days_relative_to_frost_date: 0,
      direct_seed_recommendation: :yes
    )

    post '/api/v1/users', params: body
  end

  let(:body) {{
    name: 'Joel Grant',
    email: 'joel@plantcoach.com',
    zip_code: '80121',
    password: '12345',
    password_confirmation: '12345'
  }}

  let(:user_response) { JSON.parse(response.body, symbolize_names: true) }
  let(:user) { User.find_by_id(user_response[:user][:data][:id]) }

  let(:plant) { user.plants.create!(
    name: "Sungold",
    plant_type: "Tomato",
    days_relative_to_frost_date: 14,
    days_to_maturity: 60,
    hybrid_status: 1
  ) }
  let(:plant1)  { user.plants.create!(
    name: "Jalafuego",
    plant_type: "Pepper",
    days_relative_to_frost_date: 14,
    days_to_maturity: 65,
    hybrid_status: 1
  ) }
  let(:plant2) { user.plants.create!(
    name: "Rosa Bianca",
    plant_type: "Eggplant",
    days_relative_to_frost_date: 14,
    days_to_maturity: 70,
    hybrid_status: 1
  ) }

  describe 'GET /plants_in_the_garden' do
    it 'retrieves the plants that have reached the stage of being planted in the ground' do

      # Create three seeds that have been sewn but not transplanted, which is the
      # distinguishing difference of this test...
      post '/api/v1/garden_plants', params: {
        plant_id: plant.id,
        start_from_seed: :yes,
        actual_seed_sewing_date: Date.yesterday,
        planting_status: "started_indoors"
        },
        headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
      }

      post '/api/v1/garden_plants', params: {
        plant_id: plant1.id,
        start_from_seed: :yes,
        actual_seed_sewing_date: Date.yesterday,
        planting_status: "started_indoors"
        },
        headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
      }

      post '/api/v1/garden_plants', params: {
        plant_id: plant2.id,
        start_from_seed: :yes,
        actual_seed_sewing_date: Date.yesterday,
        planting_status: "started_indoors"
        },
        headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
      }

      last_garden_plant = GardenPlant.last

      # Only one of the 3 plants are now planted in the ground - we expect one below.
      patch "/api/v1/garden_plants/#{last_garden_plant.id}", params: {
        actual_transplant_date: Date.today,
        planting_status: "transplanted_outside"
        }, headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }

      get '/api/v1/plants_in_the_garden', headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
        }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data].count).to eq(1)

      result[:data].each do |plant|
        expect(plant[:attributes][:actual_transplant_date]).to_not be nil
        expect(plant[:attributes][:planting_status]).to eq "transplanted_outside"
      end
    end
  end
end
