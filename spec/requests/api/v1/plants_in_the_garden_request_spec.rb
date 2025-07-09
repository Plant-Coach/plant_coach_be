require 'rails_helper'
require './spec/support/user_setup'

RSpec.describe 'Plants In The Garden API Endpoint', :vcr do
  include_context 'user_setup'

  let(:plant) do
    @user.plants.create!(
      name: 'Sungold',
      plant_type: 'Tomato',
      days_relative_to_frost_date: 14,
      days_to_maturity: 60,
      hybrid_status: 1
    )
  end
  let(:plant1) do
    @user.plants.create!(
      name: 'Jalafuego',
      plant_type: 'Pepper',
      days_relative_to_frost_date: 14,
      days_to_maturity: 65,
      hybrid_status: 1
    )
  end
  let(:plant2) do
    @user.plants.create!(
      name: 'Rosa Bianca',
      plant_type: 'Eggplant',
      days_relative_to_frost_date: 14,
      days_to_maturity: 70,
      hybrid_status: 1
    )
  end

  describe 'GET /plants_in_the_garden' do
    it 'retrieves the plants that have reached the stage of being planted in the ground' do
      # Create three seeds that have been sewn but not transplanted, which is the
      # distinguishing difference of this test...
      post '/api/v1/garden_plants', params: {
        plant_id: plant.id,
        name: 'Sungold',
        plant_type: 'Tomato',
        days_relative_to_frost_date: 14,
        days_to_maturity: 60,
        hybrid_status: :open_pollinated,
        organic: false,
        plant_start_method: :indirect_sew,
        actual_seed_sewing_date: Date.yesterday,
        planting_status: 'started_indoors'
      }, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      post '/api/v1/garden_plants', params: {
        plant_id: plant1.id,
        name: 'Jalafuego',
        plant_type: 'Pepper',
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: :open_pollinated,
        organic: false,
        plant_start_method: :indirect_sew,
        actual_seed_sewing_date: Date.yesterday,
        planting_status: 'started_indoors'
      }, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      post '/api/v1/garden_plants', params: {
        plant_id: plant2.id,
        name: 'Rosa Bianca',
        plant_type: 'Eggplant',
        days_relative_to_frost_date: 14,
        days_to_maturity: 70,
        hybrid_status: :open_pollinated,
        organic: false,
        plant_start_method: :indirect_sew,
        actual_seed_sewing_date: Date.yesterday,
        planting_status: 'started_indoors'
      }, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      last_garden_plant = GardenPlant.last

      # Only one of the 3 plants are now planted in the ground - we expect one below.
      patch "/api/v1/garden_plants/#{last_garden_plant.id}", params: {
        actual_transplant_date: Date.today,
        planting_status: 'transplanted_outside'
      }, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      get '/api/v1/plants_in_the_garden', headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data].count).to eq(1)

      result[:data].each do |plant|
        expect(plant[:attributes][:actual_transplant_date]).to_not be nil
        expect(plant[:attributes][:planting_status]).to eq 'transplanted_outside'
      end
    end
  end
end
