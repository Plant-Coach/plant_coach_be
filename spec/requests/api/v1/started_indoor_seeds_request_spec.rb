require 'rails_helper'

RSpec.describe 'StartedIndoorSeeds API Endpoints', :vcr do
  before(:each) do
    ActiveRecord::Base.skip_callbacks = false

    body = {
      name: 'Joel Grant',
      email: 'joel@plantcoach.com',
      zip_code: '80121',
      password: '12345',
      password_confirmation: '12345'
    }
    post '/api/v1/users', params: body

    @user_response = JSON.parse(response.body, symbolize_names: true)
    @user = User.find_by_id(@user_response[:user][:data][:id])

    @user.plant_guides.create(
      plant_type: 'Something else',
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 45,
      days_relative_to_frost_date: 14,
      harvest_period: 'one_time'
    )

    @tomato_guide = @user.plant_guides.create(
      plant_type: 'Tomato',
      seedling_days_to_transplant: 49,
      direct_seed_recommended: false,
      days_to_maturity: 55,
      days_relative_to_frost_date: 14,
      harvest_period: 'season_long'
    )

    @user.plant_guides.create(
      plant_type: 'Pepper',
      seedling_days_to_transplant: 49,
      direct_seed_recommended: false,
      days_to_maturity: 45,
      days_relative_to_frost_date: 14,
      harvest_period: 'season_long'
    )
    @user.plant_guides.create(
      plant_type: 'Eggplant',
      seedling_days_to_transplant: 49,
      direct_seed_recommended: false,
      days_to_maturity: 45,
      days_relative_to_frost_date: 14,
      harvest_period: 'season_long'
    )
    @user.plant_guides.create(
      plant_type: 'Romaine Lettuce',
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 45,
      days_relative_to_frost_date: 14,
      harvest_period: 'one_time'
    )
    @user.plant_guides.create(
      plant_type: 'Green Bean',
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 45,
      days_relative_to_frost_date: 14,
      harvest_period: 'season_long'
    )
    @user.plant_guides.create(
      plant_type: 'Radish',
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 45,
      days_relative_to_frost_date: 14,
      harvest_period: 'one_time'
    )
    @user.plant_guides.create(
      plant_type: 'Carrot',
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 60,
      days_relative_to_frost_date: -30,
      harvest_period: 'one_week'
    )
    @user.plant_guides.create(
      plant_type: 'Sprouting Broccoli',
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 45,
      days_relative_to_frost_date: -30,
      harvest_period: 'four_week'
    )
    @user.plant_guides.create(
      plant_type: 'Basil',
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 30,
      days_relative_to_frost_date: 0,
      harvest_period: 'three_week'
    )
    @user.plant_guides.create(
      plant_type: 'Cilantro',
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 30,
      days_relative_to_frost_date: 0,
      harvest_period: 'two_week'
    )
  end

  # let(:body) {{
  #   name: 'Joel Grant',
  #   email: 'joel@plantcoach.com',
  #   zip_code: '80121',
  #   password: '12345',
  #   password_confirmation: '12345'
  # }}

  # let(:user_response) { JSON.parse(response.body, symbolize_names: true) }
  # let(:user) { User.find_by_id(user_response[:user][:data][:id]) }

  let(:plant1_object) do
    @user.plants.create!(
      name: 'Sungold',
      plant_type: 'Tomato',
      days_relative_to_frost_date: 14,
      days_to_maturity: 60,
      hybrid_status: 1
    )
  end
  let(:plant2_object) do
    @user.plants.create!(
      name: 'Jalafuego',
      plant_type: 'Pepper',
      days_relative_to_frost_date: 14,
      days_to_maturity: 65,
      hybrid_status: 1
    )
  end
  let(:plant3_object) do
    @user.plants.create!(
      name: 'Rosa Bianca',
      plant_type: 'Eggplant',
      days_relative_to_frost_date: 14,
      days_to_maturity: 70,
      hybrid_status: 1
    )
  end
  let(:plant4_object) do
    @user.plants.create!(
      name: 'Coastal Star',
      plant_type: 'Romaine Lettuce',
      days_relative_to_frost_date: -45,
      days_to_maturity: 30,
      hybrid_status: 1
    )
  end
  context 'when a user wants to see a list of seeds they are growing indoors' do
    describe 'GET /started_indoor_seeds' do
      it 'gets all the plants in the users garden that have also been started inside and not yet transplanted outdoors' do
        post '/api/v1/garden_plants', params: {
          plant_id: plant1_object.id,
          plant_type: 'Tomato',
          name: 'Sungold',
          days_relative_to_frost_date: 14,
          days_to_maturity: 54,
          hybrid_status: :open_pollinated,
          organic: false,
          actual_seed_sewing_date: Date.yesterday,
          plant_start_method: :indirect_sew,
          planting_status: 'started_indoors'
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
          actual_seed_sewing_date: Date.yesterday,
          planting_status: 'started_indoors'
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
          actual_seed_sewing_date: Date.yesterday,
          planting_status: 'started_indoors'
        }, headers: {
          Authorization: "Bearer #{@user_response[:jwt]}"
        }

        get '/api/v1/started_indoor_seeds', headers: {
          Authorization: "Bearer #{@user_response[:jwt]}"
        }

        result = JSON.parse(response.body, symbolize_names: true)

        expect(result[:data].count).to eq(3)

        result[:data].each do |plant|
          expect(plant[:attributes][:actual_transplant_date]).to be nil
          expect(plant[:attributes][:direct_seed_recommended]).to eq(false)
          expect(plant[:attributes][:planting_status]).to eq 'started_indoors'
        end
      end

      it 'does not get any plants that have not been started' do
        post '/api/v1/garden_plants', params: {
          plant_id: plant1_object.id,
          plant_type: 'Tomato',
          name: 'Sungold',
          days_relative_to_frost_date: 14,
          days_to_maturity: 54,
          hybrid_status: :open_pollinated,
          organic: false,
          actual_seed_sewing_date: Date.yesterday,
          plant_start_method: :indirect_sew,
          planting_status: 'started_indoors'
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
          actual_seed_sewing_date: Date.yesterday,
          planting_status: 'started_indoors'
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
          actual_seed_sewing_date: Date.yesterday,
          planting_status: 'started_indoors'
        }, headers: {
          Authorization: "Bearer #{@user_response[:jwt]}"
        }

        post '/api/v1/garden_plants', params: {
          plant_id: plant4_object.id,
          sname: 'Coastal Star',
          plant_type: 'Romaine Lettuce',
          days_relative_to_frost_date: -45,
          days_to_maturity: 30,
          hybrid_status: :open_pollinated,
          organic: false,
          plant_start_method: :indirect_sew,
          actual_seed_sewing_date: Date.yesterday,
          planting_status: 'direct_sewn_outside'
        }, headers: {
          Authorization: "Bearer #{@user_response[:jwt]}"
        }

        get '/api/v1/started_indoor_seeds', headers: {
          Authorization: "Bearer #{@user_response[:jwt]}"
        }

        result = JSON.parse(response.body, symbolize_names: true)

        expect(result[:data].count).to eq(3)

        result[:data].each do |plant|
          expect(plant[:attributes][:plant_type]).to_not eq('Romaine Lettuce')
          expect(plant[:attributes][:direct_seed_recommended]).to_not be true
          expect(plant[:attributes][:planting_status]).to_not eq('not started')

          expect(plant[:attributes][:actual_transplant_date]).to be nil
          expect(plant[:attributes][:direct_seed_recommended]).to eq(false)
          expect(plant[:attributes][:planting_status]).to eq 'started_indoors'
        end
      end

      it 'will not include plants that are waiting to be planted' do
        post '/api/v1/garden_plants', params: {
          plant_id: plant1_object.id,
          plant_type: 'Tomato',
          name: 'Sungold',
          days_relative_to_frost_date: 14,
          days_to_maturity: 54,
          hybrid_status: :open_pollinated,
          organic: false,
          actual_seed_sewing_date: Date.yesterday,
          plant_start_method: :indirect_sew,
          planting_status: 'started_indoors'
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
          actual_seed_sewing_date: Date.yesterday,
          planting_status: 'started_indoors'
        }, headers: {
          Authorization: "Bearer #{@user_response[:jwt]}"
        }

        # This plant is not started yet
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

        post '/api/v1/garden_plants', params: {
          plant_id: plant4_object.id,
          sname: 'Coastal Star',
          plant_type: 'Romaine Lettuce',
          days_relative_to_frost_date: -45,
          days_to_maturity: 30,
          hybrid_status: :open_pollinated,
          organic: false,
          plant_start_method: :direct_sew,
          actual_seed_sewing_date: Date.yesterday,
          planting_status: 'direct_sewn_outside'
        }, headers: {
          Authorization: "Bearer #{@user_response[:jwt]}"
        }

        get '/api/v1/started_indoor_seeds', headers: {
          Authorization: "Bearer #{@user_response[:jwt]}"
        }

        result = JSON.parse(response.body, symbolize_names: true)

        expect(result[:data].count).to eq(2)

        result[:data].each do |plant|
          expect(plant[:attributes][:plant_type]).to_not eq('Eggplant')

          expect(plant[:attributes][:actual_transplant_date]).to be nil
          expect(plant[:attributes][:direct_seed_recommended]).to eq(false)
          expect(plant[:attributes][:planting_status]).to eq 'started_indoors'
        end
      end

      it 'will not include plants that have been transplanted outdoors' do
        post '/api/v1/garden_plants', params: {
          plant_id: plant1_object.id,
          plant_type: 'Tomato',
          name: 'Sungold',
          days_relative_to_frost_date: 14,
          days_to_maturity: 54,
          hybrid_status: :open_pollinated,
          organic: false,
          actual_seed_sewing_date: Date.yesterday,
          plant_start_method: :indirect_sew,
          planting_status: 'started_indoors'
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
          actual_seed_sewing_date: Date.yesterday,
          planting_status: 'started_indoors'
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
          actual_seed_sewing_date: Date.yesterday,
          planting_status: 'started_indoors'
        }, headers: {
          Authorization: "Bearer #{@user_response[:jwt]}"
        }

        last_garden_plant = GardenPlant.last

        # Mimicks a plant who is plant outside, to test for false positives.
        patch "/api/v1/garden_plants/#{last_garden_plant.id}", params: {
          actual_transplant_date: Date.today,
          planting_status: 'transplanted_outside'
        }, headers: {
          Authorization: "Bearer #{@user_response[:jwt]}"
        }

        get '/api/v1/started_indoor_seeds', headers: {
          Authorization: "Bearer #{@user_response[:jwt]}"
        }

        result = JSON.parse(response.body, symbolize_names: true)

        expect(result[:data].count).to eq(2)

        result[:data].each do |plant|
          expect(plant[:attributes][:plant_type]).to_not eq('Eggplant')

          expect(plant[:attributes][:actual_transplant_date]).to be nil
          expect(plant[:attributes][:direct_seed_recommended]).to eq(false)
          expect(plant[:attributes][:planting_status]).to eq 'started_indoors'
        end
      end

      it 'will not include plants that are direct-sewn' do
        post '/api/v1/garden_plants', params: {
          plant_id: plant1_object.id,
          plant_type: 'Tomato',
          name: 'Sungold',
          days_relative_to_frost_date: 14,
          days_to_maturity: 54,
          hybrid_status: :open_pollinated,
          organic: false,
          actual_seed_sewing_date: Date.yesterday,
          plant_start_method: :indirect_sew,
          planting_status: 'started_indoors'
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
          actual_seed_sewing_date: Date.yesterday,
          planting_status: 'started_indoors'
        }, headers: {
          Authorization: "Bearer #{@user_response[:jwt]}"
        }

        post '/api/v1/garden_plants', params: {
          plant_id: plant4_object.id,
          sname: 'Coastal Star',
          plant_type: 'Romaine Lettuce',
          days_relative_to_frost_date: -45,
          days_to_maturity: 30,
          hybrid_status: :open_pollinated,
          organic: false,
          plant_start_method: :direct_sew,
          actual_seed_sewing_date: Date.yesterday,
          planting_status: 'direct_sewn_outside'
        }, headers: {
          Authorization: "Bearer #{@user_response[:jwt]}"
        }

        GardenPlant.last

        get '/api/v1/started_indoor_seeds', headers: {
          Authorization: "Bearer #{@user_response[:jwt]}"
        }

        result = JSON.parse(response.body, symbolize_names: true)

        expect(result[:data].count).to eq(2)

        result[:data].each do |plant|
          expect(plant[:attributes][:plant_type]).to_not eq('Romaine Lettuce')

          expect(plant[:attributes][:actual_transplant_date]).to be nil
          expect(plant[:attributes][:direct_seed_recommended]).to eq(false)
          expect(plant[:attributes][:planting_status]).to eq 'started_indoors'
        end
      end
    end
  end
end
