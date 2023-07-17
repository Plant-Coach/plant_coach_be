require 'rails_helper'

RSpec.describe 'StartedIndoorSeeds API Endpoints', :vcr do
  before(:each) do
    ActiveRecord::Base.skip_callbacks = false

    tomato_seed = SeedGuide.create(
      plant_type: "Tomato",
      seedling_days_to_transplant: 49,
      direct_seed_recommended: false
    )
    pepper_seed = SeedGuide.create(
      plant_type: "Pepper",
      seedling_days_to_transplant: 49,
      direct_seed_recommended: false
    )
    eggplant_seed = SeedGuide.create(
      plant_type: "Eggplant",
      seedling_days_to_transplant: 49,
      direct_seed_recommended: false
    )
    romaine_seed = SeedGuide.create(
      plant_type: "Romaine Lettuce",
      seedling_days_to_transplant: 14,
      direct_seed_recommended: true
    )
    green_bean_seed = SeedGuide.create(
      plant_type: "Green Bean",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true
    )
    radish_seed = SeedGuide.create(
      plant_type: "Radish",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true
      )
    romaine_seed = SeedGuide.create(
      plant_type: "Romaine Lettuce",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true
      )

    tomato_transplant = TransplantGuide.create(
      plant_type: "Tomato",
      days_to_maturity: 45,
      days_relative_to_frost_date: 14
    )
    pepper_transplant = TransplantGuide.create(
      plant_type: "Pepper",
      days_to_maturity: 45,
      days_relative_to_frost_date: 14
    )
    eggplant_transplant = TransplantGuide.create(
      plant_type: "Eggplant",
      days_to_maturity: 45,
      days_relative_to_frost_date: 14
    )
    romaine_transplant = TransplantGuide.create(
      plant_type: "Romaine Lettuce",
      days_to_maturity: 45,
      days_relative_to_frost_date: 14
    )
    green_bean_transplant =TransplantGuide.create(
      plant_type: "Green Bean",
      days_to_maturity: 45,
      days_relative_to_frost_date: 14
    )
    radish_transplant = TransplantGuide.create(
      plant_type: "Radish",
      days_to_maturity: 45,
      days_relative_to_frost_date: 14
    )
    romaine_transplant = TransplantGuide.create(
      plant_type: "Romaine Lettuce",
      days_to_maturity: 45,
      days_relative_to_frost_date: 14
    )

    tomato_harvest = HarvestGuide.create(
      plant_type: "Tomato",
      harvest_period: "season_long"
    )
    pepper_harvest = HarvestGuide.create(
      plant_type: "Pepper",
      harvest_period: "season_long"
    )
    eggplant_harvest = HarvestGuide.create(
      plant_type: "Eggplant",
      harvest_period: "season_long"
    )
    romaine_harvest = HarvestGuide.create(
      plant_type: "Romaine Lettuce",
      harvest_period: "season_long"
    )
    green_bean_harvest = HarvestGuide.create(
      plant_type: "Green Bean",
      harvest_period: "season_long"
    )
    radish_harvest = HarvestGuide.create(
      plant_type: "Radish",
      harvest_period: "season_long"
    )
    radish_harvest = HarvestGuide.create(
      plant_type: "Romaine Lettuce",
      harvest_period: "one_time"
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

  let(:plant1_object) { user.plants.create!(
    name: "Sungold",
    plant_type: "Tomato",
    days_relative_to_frost_date: 14,
    days_to_maturity: 60,
    hybrid_status: 1
  ) }
  let(:plant2_object)  { user.plants.create!(
    name: "Jalafuego",
    plant_type: "Pepper",
    days_relative_to_frost_date: 14,
    days_to_maturity: 65,
    hybrid_status: 1
  ) }
  let(:plant3_object) { user.plants.create!(
    name: "Rosa Bianca",
    plant_type: "Eggplant",
    days_relative_to_frost_date: 14,
    days_to_maturity: 70,
    hybrid_status: 1
  ) }
  let(:plant4_object) { user.plants.create!(
    name: "Coastal Star",
    plant_type: "Romaine Lettuce",
    days_relative_to_frost_date: -45,
    days_to_maturity: 30,
    hybrid_status: 1
  ) }
  context 'when a user wants to see a list of seeds they are growing indoors' do


  describe 'GET /started_indoor_seeds' do
    it 'gets all the plants in the users garden that have also been started inside and not yet transplanted outdoors' do

      post '/api/v1/garden_plants', params: {
        plant_id: plant1_object.id,
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: :open_pollinated,
        organic: false,
        start_from_seed: true,
        actual_seed_sewing_date: Date.yesterday,
        seed_sew_type: :indirect,
        planting_status: "started_indoors"
        }

        post '/api/v1/garden_plants', params: {
          plant_id: plant2_object.id,
          name: "Jalafuego",
          plant_type: "Pepper",
          days_relative_to_frost_date: 14,
          days_to_maturity: 65,
          hybrid_status: :open_pollinated,
          organic: false,
          start_from_seed: true,
          seed_sew_type: :indirect,
          actual_seed_sewing_date: Date.yesterday,
          planting_status: "started_indoors"
          }

        post '/api/v1/garden_plants', params: {
          plant_id: plant3_object.id,
          name: "Rosa Bianca",
          plant_type: "Eggplant",
          days_relative_to_frost_date: 14,
          days_to_maturity: 70,
          hybrid_status: :open_pollinated,
          organic: false,
          start_from_seed: true,
          seed_sew_type: :indirect,
          actual_seed_sewing_date: Date.yesterday,
          planting_status: "started_indoors"
          }

      get '/api/v1/started_indoor_seeds'
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data].count).to eq(3)

      result[:data].each do |plant|
        expect(plant[:attributes][:actual_transplant_date]).to be nil
        expect(plant[:attributes][:direct_seed_recommended]).to eq(false)
        expect(plant[:attributes][:planting_status]).to eq "started_indoors"
        expect(plant[:attributes][:start_from_seed]).to be true
      end
    end

    it 'does not get any plants that have not been started' do

      post '/api/v1/garden_plants', params: {
        plant_id: plant1_object.id,
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: :open_pollinated,
        organic: false,
        start_from_seed: true,
        actual_seed_sewing_date: Date.yesterday,
        seed_sew_type: :indirect,
        planting_status: "started_indoors"
        }

        post '/api/v1/garden_plants', params: {
        plant_id: plant2_object.id,
        name: "Jalafuego",
          plant_type: "Pepper",
          days_relative_to_frost_date: 14,
          days_to_maturity: 65,
          hybrid_status: :open_pollinated,
          organic: false,
          start_from_seed: true,
          seed_sew_type: :indirect,
          actual_seed_sewing_date: Date.yesterday,
          planting_status: "started_indoors"
          }

        post '/api/v1/garden_plants', params: {
          plant_id: plant3_object.id,
          name: "Rosa Bianca",
          plant_type: "Eggplant",
          days_relative_to_frost_date: 14,
          days_to_maturity: 70,
          hybrid_status: :open_pollinated,
          organic: false,
          start_from_seed: true,
          seed_sew_type: :indirect,
          actual_seed_sewing_date: Date.yesterday,
          planting_status: "started_indoors"
          }

      post '/api/v1/garden_plants', params: {
        plant_id: plant4_object.id,
        sname: "Coastal Star",
        plant_type: "Romaine Lettuce",
        days_relative_to_frost_date: -45,
        days_to_maturity: 30,
        hybrid_status: :open_pollinated,
        organic: false,
        start_from_seed: true,
        seed_sew_type: :indirect,
        actual_seed_sewing_date: Date.yesterday,
        planting_status: "direct_sewn_outside"
        }

      get '/api/v1/started_indoor_seeds'
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data].count).to eq(3)

      result[:data].each do |plant|
        expect(plant[:attributes][:plant_type]).to_not eq("Romaine Lettuce")
        expect(plant[:attributes][:direct_seed_recommended]).to_not be true
        expect(plant[:attributes][:planting_status]).to_not eq("not started")
        expect(plant[:attributes][:start_from_seed]).to_not be false


        expect(plant[:attributes][:actual_transplant_date]).to be nil
        expect(plant[:attributes][:direct_seed_recommended]).to eq(false)
        expect(plant[:attributes][:planting_status]).to eq "started_indoors"
        expect(plant[:attributes][:start_from_seed]).to be true
      end
    end

    it 'will not include plants that are waiting to be planted' do

      post '/api/v1/garden_plants', params: {
        plant_id: plant1_object.id,
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: :open_pollinated,
        organic: false,
        start_from_seed: true,
        actual_seed_sewing_date: Date.yesterday,
        seed_sew_type: :indirect,
        planting_status: "started_indoors"
      }

      post '/api/v1/garden_plants', params: {
        plant_id: plant2_object.id,
        name: "Jalafuego",
        plant_type: "Pepper",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: :open_pollinated,
        organic: false,
        start_from_seed: true,
        seed_sew_type: :indirect,
        actual_seed_sewing_date: Date.yesterday,
        planting_status: "started_indoors"
      }

      # This plant is not started yet
      post '/api/v1/garden_plants', params: {
        plant_id: plant3_object.id,
        name: "Rosa Bianca",
        plant_type: "Eggplant",
        days_relative_to_frost_date: 14,
        days_to_maturity: 70,
        hybrid_status: :open_pollinated,
        organic: false,
        start_from_seed: true,
        seed_sew_type: :indirect,
        actual_seed_sewing_date: nil,
        planting_status: "not_started"
      }

      post '/api/v1/garden_plants', params: {
        plant_id: plant4_object.id,
        sname: "Coastal Star",
        plant_type: "Romaine Lettuce",
        days_relative_to_frost_date: -45,
        days_to_maturity: 30,
        hybrid_status: :open_pollinated,
        organic: false,
        start_from_seed: true,
        seed_sew_type: :direct,
        actual_seed_sewing_date: Date.yesterday,
        planting_status: "direct_sewn_outside"
      }

      get '/api/v1/started_indoor_seeds'
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data].count).to eq(2)

      result[:data].each do |plant|
        expect(plant[:attributes][:plant_type]).to_not eq("Eggplant")

        expect(plant[:attributes][:actual_transplant_date]).to be nil
        expect(plant[:attributes][:direct_seed_recommended]).to eq(false)
        expect(plant[:attributes][:planting_status]).to eq "started_indoors"
        expect(plant[:attributes][:start_from_seed]).to be true
      end
    end

    it 'will not include plants that have been transplanted outdoors' do

      post '/api/v1/garden_plants', params: {
        plant_id: plant1_object.id,
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: :open_pollinated,
        organic: false,
        start_from_seed: true,
        actual_seed_sewing_date: Date.yesterday,
        seed_sew_type: :indirect,
        planting_status: "started_indoors"
      }

      post '/api/v1/garden_plants', params: {
        plant_id: plant2_object.id,
        name: "Jalafuego",
        plant_type: "Pepper",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: :open_pollinated,
        organic: false,
        start_from_seed: true,
        seed_sew_type: :indirect,
        actual_seed_sewing_date: Date.yesterday,
        planting_status: "started_indoors"
      }

      post '/api/v1/garden_plants', params: {
        plant_id: plant3_object.id,
        name: "Rosa Bianca",
        plant_type: "Eggplant",
        days_relative_to_frost_date: 14,
        days_to_maturity: 70,
        hybrid_status: :open_pollinated,
        organic: false,
        start_from_seed: true,
        seed_sew_type: :indirect,
        actual_seed_sewing_date: Date.yesterday,
        planting_status: "started_indoors"
      }

      last_garden_plant = GardenPlant.last

      # Mimicks a plant who is plant outside, to test for false positives.
      patch "/api/v1/garden_plants/#{last_garden_plant.id}", params: {
        actual_transplant_date: Date.today,
        planting_status: "transplanted_outside" }

      get '/api/v1/started_indoor_seeds'
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data].count).to eq(2)

      result[:data].each do |plant|
        expect(plant[:attributes][:plant_type]).to_not eq("Eggplant")

        expect(plant[:attributes][:actual_transplant_date]).to be nil
        expect(plant[:attributes][:direct_seed_recommended]).to eq(false)
        expect(plant[:attributes][:planting_status]).to eq "started_indoors"
        expect(plant[:attributes][:start_from_seed]).to be true
      end
    end

    it 'will not include plants that are direct-sewn' do

      post '/api/v1/garden_plants', params: {
        plant_id: plant1_object.id,
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: :open_pollinated,
        organic: false,
        start_from_seed: true,
        actual_seed_sewing_date: Date.yesterday,
        seed_sew_type: :indirect,
        planting_status: "started_indoors"
      }

      post '/api/v1/garden_plants', params: {
        plant_id: plant2_object.id,
        name: "Jalafuego",
        plant_type: "Pepper",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: :open_pollinated,
        organic: false,
        start_from_seed: true,
        seed_sew_type: :indirect,
        actual_seed_sewing_date: Date.yesterday,
        planting_status: "started_indoors"
      }

      post '/api/v1/garden_plants', params: {
        plant_id: plant4_object.id,
        sname: "Coastal Star",
        plant_type: "Romaine Lettuce",
        days_relative_to_frost_date: -45,
        days_to_maturity: 30,
        hybrid_status: :open_pollinated,
        organic: false,
        start_from_seed: true,
        seed_sew_type: :direct,
        actual_seed_sewing_date: Date.yesterday,
        planting_status: "direct_sewn_outside"
      }

      last_garden_plant = GardenPlant.last

      get '/api/v1/started_indoor_seeds'

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data].count).to eq(2)

      result[:data].each do |plant|
        expect(plant[:attributes][:plant_type]).to_not eq("Romaine Lettuce")

        expect(plant[:attributes][:actual_transplant_date]).to be nil
        expect(plant[:attributes][:direct_seed_recommended]).to eq(false)
        expect(plant[:attributes][:planting_status]).to eq "started_indoors"
        expect(plant[:attributes][:start_from_seed]).to be true
      end
    end
  end
  end
end
