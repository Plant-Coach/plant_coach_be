require 'rails_helper'

RSpec.describe 'Plant API Endpoints', :vcr do
  before(:each) do
    tomato_seed = SeedGuide.create(
      plant_type: "Tomato",
      seedling_days_to_transplant: 49,
      direct_seed_recommended: false,
      recommended_transplant_date: true,
      recommended_seed_start_date: true
    )
    pepper_seed = SeedGuide.create(
      plant_type: "Pepper",
      seedling_days_to_transplant: 49,
      direct_seed_recommended: false,
      recommended_transplant_date: true,
      recommended_seed_start_date: true
    )
    eggplant_seed = SeedGuide.create(
      plant_type: "Eggplant",
      seedling_days_to_transplant: 49,
      direct_seed_recommended: false,
      recommended_transplant_date: true,
      recommended_seed_start_date: true
    )
    romaine_seed = SeedGuide.create(
      plant_type: "Romaine Lettuce",
      seedling_days_to_transplant: 14,
      direct_seed_recommended: true,
      recommended_transplant_date: true,
      recommended_seed_start_date: true
    )
    green_bean_seed = SeedGuide.create(
      plant_type: "Green Bean",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      recommended_transplant_date: true,
      recommended_seed_start_date: true
    )
    radish_seed = SeedGuide.create(
      plant_type: "Radish",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      recommended_transplant_date: true,
      recommended_seed_start_date: true
      )
    romaine_seed = SeedGuide.create(
      plant_type: "Romaine Lettuce",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      recommended_transplant_date: true,
      recommended_seed_start_date: true
      )
      sprouting_broccoli_seed = SeedGuide.create(
      plant_type: "Sprouting Broccoli",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      recommended_transplant_date: true,
      recommended_seed_start_date: true
    )
    basil_seed = SeedGuide.create(
      plant_type: "Basil",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      recommended_transplant_date: true,
      recommended_seed_start_date: true
    )
    cilantro_seed = SeedGuide.create(
      plant_type: "Cilantro",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      recommended_transplant_date: true,
      recommended_seed_start_date: true
    )
    carrot_seed = SeedGuide.create(
      plant_type: "Carrot",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      recommended_transplant_date: true,
      recommended_seed_start_date: true
    )

    tomato_transplant = TransplantGuide.create(
      plant_type: "Tomato",
      days_to_maturity: 55,
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
    sprouting_broccoli_transplant = TransplantGuide.create(
      plant_type: "Sprouting Broccoli",
      days_to_maturity: 45,
      days_relative_to_frost_date: -30
    )
    basil_transplant = TransplantGuide.create(
      plant_type: "Basil",
      days_to_maturity: 30,
      days_relative_to_frost_date: 0
    )
    cilantro_transplant = TransplantGuide.create(
      plant_type: "Cilantro",
      days_to_maturity: 30,
      days_relative_to_frost_date: 0
    )
    carrot_transplant = TransplantGuide.create(
      plant_type: "Carrot",
      days_to_maturity: 60,
      days_relative_to_frost_date: -30
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
    sprouting_broccoli_harvest = HarvestGuide.create(
      plant_type: "Sprouting Broccoli",
      harvest_period: "four_week"
    )
    basil_harvest = HarvestGuide.create(
      plant_type: "Basil",
      harvest_period: "three_week"
    )
    cilantro_harvest = HarvestGuide.create(
      plant_type: "Cilantro",
      harvest_period: "two_week"
    )
    carrot_harvest = HarvestGuide.create(
      plant_type: "Carrot",
      harvest_period: "one_week"
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

  let(:plant1_params) { {
    plant_type: "Tomato",
    name: "Sungold",
    days_relative_to_frost_date: 14,
    days_to_maturity: 54,
    hybrid_status: :f1
  } }
  let(:plant2_params) { {
    plant_type: "Pepper",
    name: "Round of Hungary",
    days_relative_to_frost_date: 14,
    days_to_maturity: 60,
    hybrid_status: :f1
  } }
  let(:plant3_params) { {
    plant_type: "Eggplant",
    name: "Rosa Bianca",
    days_relative_to_frost_date: 14,
    days_to_maturity: 68,
    hybrid_status: :open_pollinated
  } }
  let(:plant4_params) { {
    plant_type: "Romaine Lettuce",
    name: "Costal Star",
    days_relative_to_frost_date: 30,
    days_to_maturity: 25,
    hybrid_status: :f1
  } }
  let(:plant5_params) { {
    plant_type: "Green Bean",
    name: "Provider",
    days_relative_to_frost_date: -7,
    days_to_maturity: 45,
    hybrid_status: :f1
  } }

  let(:user_response) { JSON.parse(response.body, symbolize_names: true) }
  let(:user) { User.find_by_id(user_response[:user][:data][:id]) }

  let(:last_user) { User.last }

  let(:plant1_object) { last_user.plants.create!(
    plant_type: "Tomato",
    name: "Sungold",
    days_relative_to_frost_date: 14,
    days_to_maturity: 54,
    hybrid_status: :f1
  ) }
  let(:plant2_object) { last_user.plants.create!(
    plant_type: "Pepper",
    name: "Jalafuego",
    days_relative_to_frost_date: 14,
    days_to_maturity: 65,
    hybrid_status: :f1
  ) }
  let(:plant3_object) { last_user.plants.create!(
    plant_type: "Radish",
    name: "French Breakfast",
    days_relative_to_frost_date: 30,
    days_to_maturity: 21,
    hybrid_status: :f1
  ) }

  describe 'GET /plants' do
    it 'retrieves all the plants that have been added to the application by that user' do

      # Created to make sure user's plants don't show up for other users
      other_user = {
      name: 'Bad User',
        email: 'bad@user.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }

      post '/api/v1/plants', params: plant1_params
      post '/api/v1/plants', params: plant2_params
      post '/api/v1/plants', params: plant3_params
      post '/api/v1/plants', params: plant4_params
      # Capture cookie data in order to reuse later.
      cookie_1 = response.cookies["_session_id"]

      post '/api/v1/users', params: other_user
      expect(response).to be_successful
      post '/api/v1/plants', params: plant5_params

      # Sets the cookie to call the first user's plants instead of the second user's.
      cookies["_session_id"] = cookie_1
      get '/api/v1/plants'

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
      expect(response).to be_successful

      post '/api/v1/plants', params: plant1_params
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(result).to be_a Hash
      expect(result[:data][:attributes][:name]).to eq("Sungold")
    end

    it 'will create a plant with unknown as the hybrid status if it is not provided' do
      expect(response).to be_successful

      plant_without_hybrid_status = {
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        organic: true,
        days_to_maturity: 54
      }

      post '/api/v1/plants', params: plant_without_hybrid_status

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to_not have_key(:error)
      expect(response).to be_successful
      expect(result[:data][:attributes][:hybrid_status]).to eq("unknown")
    end

    it 'will create a new plant even if the organic status is not known' do
      expect(response).to be_successful

      plant_with_missing_organic_field = {
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: :f1
      }

      post '/api/v1/plants', params: plant_with_missing_organic_field

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to_not have_key(:error)
      expect(response).to be_successful
      expect(result[:data][:attributes][:organic]).to eq(false)
    end

    it 'will replace information with default data that the user does not provide' do
      ActiveRecord::Base.skip_callbacks = false

      expect(response).to be_successful

      plant = {
        plant_type: "Tomato",
        name: "Sungold",
      }
      post '/api/v1/plants', params: plant
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(201)
      expect(result).to be_a Hash
      expect(result[:data][:attributes][:name]).to eq("Sungold")
      expect(result[:data][:attributes][:days_to_maturity]).to eq(55)
      expect(result[:data][:attributes][:days_relative_to_frost_date]).to eq(14)
    end

    it 'will assign a season-long harvest period to a plant such as a tomato' do
      expect(response).to be_successful

      plant = {
        plant_type: "Tomato",
        name: "Sungold",
      }
      post '/api/v1/plants', params: plant
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(201)

      expect(result).to be_a Hash
      expect(result[:data][:attributes][:plant_type]).to eq("Tomato")
      expect(result[:data][:attributes][:name]).to eq("Sungold")
      expect(result[:data][:attributes][:harvest_period]).to eq("season_long")
    end

    it 'will assign a season-long harvest period to a plant such as an Eggplant' do
      expect(response).to be_successful

      plant = {
        plant_type: "Eggplant",
        name: "Rosa Bianca",
      }
      post '/api/v1/plants', params: plant
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(201)

      expect(result).to be_a Hash
      expect(result[:data][:attributes][:plant_type]).to eq("Eggplant")
      expect(result[:data][:attributes][:name]).to eq("Rosa Bianca")
      expect(result[:data][:attributes][:harvest_period]).to eq("season_long")
    end

    it 'will assign a four-week harvest period to a plant such as sprouting broccoli' do
      expect(response).to be_successful

      plant = {
        plant_type: "Sprouting Broccoli",
        name: "Di Cicco",
      }
      post '/api/v1/plants', params: plant
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(201)

      expect(result).to be_a Hash
      expect(result[:data][:attributes][:plant_type]).to eq("Sprouting Broccoli")
      expect(result[:data][:attributes][:name]).to eq("Di Cicco")
      expect(result[:data][:attributes][:harvest_period]).to eq("four_week")
    end

    it 'will assign a three-week harvest period to a plant such as a cucumber' do
      expect(response).to be_successful

      plant = {
        plant_type: "Basil",
        name: "Thai Towers",
      }
      post '/api/v1/plants', params: plant
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(201)

      expect(result).to be_a Hash
      expect(result[:data][:attributes][:plant_type]).to eq("Basil")
      expect(result[:data][:attributes][:name]).to eq("Thai Towers")
      expect(result[:data][:attributes][:harvest_period]).to eq("three_week")
    end

    it 'will assign a two-week harvest period to a plant such as cilantro' do
      expect(response).to be_successful

      plant = {
        plant_type: "Cilantro",
        name: "CantThinkOfAName",
      }
      post '/api/v1/plants', params: plant
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(201)

      expect(result).to be_a Hash
      expect(result[:data][:attributes][:plant_type]).to eq("Cilantro")
      expect(result[:data][:attributes][:name]).to eq("CantThinkOfAName")
      expect(result[:data][:attributes][:harvest_period]).to eq("two_week")
    end

    it 'will assign a one-week harvest period to a plant such as a carrot' do
      expect(response).to be_successful

      plant = {
        plant_type: "Carrot",
        name: "Sugarsnax",
      }
      post '/api/v1/plants', params: plant
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(201)

      expect(result).to be_a Hash
      expect(result[:data][:attributes][:plant_type]).to eq("Carrot")
      expect(result[:data][:attributes][:name]).to eq("Sugarsnax")
      expect(result[:data][:attributes][:harvest_period]).to eq("one_week")
    end

    it 'will assign a one-time harvest period to a plant such as a head of lettuce' do
      expect(response).to be_successful

      plant = {
        plant_type: "Romaine Lettuce",
        name: "Coastal Star",
      }
      post '/api/v1/plants', params: plant
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(201)

      expect(result).to be_a Hash
      expect(result[:data][:attributes][:plant_type]).to eq("Romaine Lettuce")
      expect(result[:data][:attributes][:name]).to eq("Coastal Star")
      expect(result[:data][:attributes][:harvest_period]).to eq("one_time")
    end

    # This scenario should never happen.
    it 'will return an error message if the plant could not be created due to missing information' do
      ActiveRecord::Base.skip_callbacks = true

      expect(response).to be_successful

      plant = {
        name: "Sungold",
      }

      post '/api/v1/plants', params: plant
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key(:error)
      expect(result[:error]).to eq("The plant could not be saved!")
    end
  end

  describe 'PATCH /plants' do
    it 'updates an existing plant with new attributes' do
      expect(response).to be_successful

      patch "/api/v1/plants/#{plant1_object.id}", params: { days_to_maturity: 61 }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:attributes][:days_to_maturity]).to eq(61)
    end
  end

  describe 'DELETE /plants' do
    it 'removes a plant from the list of available plants' do
      expect(response).to be_successful

      delete "/api/v1/plants/#{plant3_object.id}"
      result = JSON.parse(response.body, symbolize_names: true)

      expect(Plant.find_by(id: plant3_object.id)).to be nil
    end

    it 'returns an error if the plant can not be found' do
      expect(response).to be_successful

      delete "/api/v1/plants/999999"

      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:error]).to eq("Something happened!")
    end
  end
end
