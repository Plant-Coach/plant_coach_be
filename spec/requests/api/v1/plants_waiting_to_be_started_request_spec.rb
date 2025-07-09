require 'rails_helper'
require './spec/support/user_setup'

RSpec.describe 'Plants Waiting To Be Started API Endpoint', :vcr do
  include_context 'user_setup'

  describe 'GET /plants_waiting_to_be_started' do
    it 'returns all the plants that have been added to the users garden but have not been transplanted or seeded' do
      # While a function of the app is to auto-provide missing attributes of a
      # new plant, that does not seem to work quickly enough while RSpec is running tests.
      # Therefore, they need to be explicitly assigned as this causes validation errors.
      # It is also not the purpose of this test.
      plant1_object = @user.plants.create!(
        name: 'Sungold',
        plant_type: 'Tomato',
        days_relative_to_frost_date: 14,
        days_to_maturity: 60,
        hybrid_status: 1
      )
      plant2_object = @user.plants.create!(
        name: 'Jalafuego',
        plant_type: 'Pepper',
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: 1
      )
      plant3_object = @user.plants.create!(
        name: 'Rosa Bianca',
        plant_type: 'Eggplant',
        days_relative_to_frost_date: 14,
        days_to_maturity: 70,
        hybrid_status: 1
      )

      post '/api/v1/garden_plants', params: {
        plant_id: plant1_object.id,
        plant_type: 'Tomato',
        name: 'Sungold',
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: :open_pollinated,
        organic: false,
        actual_seed_sewing_date: nil,
        plant_start_method: :indirect_sew,
        planting_status: 'not_started'
      }, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      post '/api/v1/garden_plants', params: {
        plant_id: plant2_object.id,
        name: 'Jalafuego',
        plant_type: 'Pepper',
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: :open_pollinated,
        organic: false,
        plant_start_method: :indirect_sew,
        actual_seed_sewing_date: nil,
        planting_status: 'not_started'
      }, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      post '/api/v1/garden_plants', params: {
        plant_id: plant3_object.id,
        name: 'Rosa Bianca',
        plant_type: 'Eggplant',
        days_relative_to_frost_date: 14,
        days_to_maturity: 70,
        hybrid_status: :open_pollinated,
        organic: false,
        plant_start_method: :indirect_sew,
        actual_seed_sewing_date: nil,
        planting_status: 'not_started'
      }, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      get '/api/v1/plants_waiting_to_be_started', headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data].count).to eq(3)

      result[:data].each do |plant|
        expect(plant[:attributes][:actual_transplant_date]).to be nil
        expect(plant[:attributes][:direct_seed_recommended]).to eq(false)
        expect(plant[:attributes][:planting_status]).to eq 'not_started'
        expect(plant[:attributes][:actual_seed_actual_seed_sewing_date]).to be nil
      end
    end
  end
end
