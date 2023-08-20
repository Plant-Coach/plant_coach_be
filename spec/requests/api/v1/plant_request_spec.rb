require 'rails_helper'

RSpec.describe 'Plant API Endpoints', :vcr do
  before(:each) do
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


    test_plant_guide = @user.plant_guides.create(
      plant_type: "Something else",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 45,
      days_relative_to_frost_date: 14,
      harvest_period: "one_time"
    )

    @tomato_guide = @user.plant_guides.create(
      plant_type: "Tomato",
      seedling_days_to_transplant: 49,
      direct_seed_recommended: false,
      days_to_maturity: 55,
      days_relative_to_frost_date: 14,
      harvest_period: "season_long"
    )
  
    pepper_guide = @user.plant_guides.create(
      plant_type: "Pepper",
      seedling_days_to_transplant: 49,
      direct_seed_recommended: false,
      days_to_maturity: 45,
      days_relative_to_frost_date: 14,
      harvest_period: "season_long"
    )
    eggplant_guide = @user.plant_guides.create(
      plant_type: "Eggplant",
      seedling_days_to_transplant: 49,
      direct_seed_recommended: false,
      days_to_maturity: 45,
      days_relative_to_frost_date: 14,
      harvest_period: "season_long"
    )
    romaine_guide = @user.plant_guides.create(
      plant_type: "Romaine Lettuce",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 45,
      days_relative_to_frost_date: 14,
      harvest_period: "one_time"
    )
    green_bean_guide = @user.plant_guides.create(
      plant_type: "Green Bean",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 45,
      days_relative_to_frost_date: 14,
      harvest_period: "season_long"
    )
    radish_guide = @user.plant_guides.create(
      plant_type: "Radish",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 45,
      days_relative_to_frost_date: 14,
      harvest_period: "one_time"
    )
    carrot_guide = @user.plant_guides.create(
      plant_type: "Carrot",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 60,
      days_relative_to_frost_date: -30,
      harvest_period: "one_week"
    )
    sprouting_broccoli_guide = @user.plant_guides.create(
      plant_type: "Sprouting Broccoli",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 45,
      days_relative_to_frost_date: -30,
      harvest_period: "four_week"
    )
    basil_guide = @user.plant_guides.create(
      plant_type: "Basil",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 30,
      days_relative_to_frost_date: 0,
      harvest_period: "three_week"
    )
    cilantro_guide = @user.plant_guides.create(
      plant_type: "Cilantro",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 30,
      days_relative_to_frost_date: 0,
      harvest_period: "two_week"
    )
    raspberry_guide = @user.plant_guides.create(
      plant_type: "Raspberry",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: false,
      days_to_maturity: 100,
      days_relative_to_frost_date: 0,
      harvest_period: "season_long"
    )
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
  # let(:plant4_object) { last_user.plants.create!(
  #   plant_type: "Tomato",
  #   name: "Nova",
  #   days_relative_to_frost_date: 14,
  #   days_to_maturity: 48,
  #   hybrid_status: :f1
  # ) }

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

      post '/api/v1/plants', params: plant1_params, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }
      post '/api/v1/plants', params: plant2_params, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }
      post '/api/v1/plants', params: plant3_params, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }
      post '/api/v1/plants', params: plant4_params, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      post '/api/v1/users', params: other_user

      expect(response).to be_successful
      second_user_response = JSON.parse(response.body, symbolize_names: true)
      second_user = User.find_by_id(user_response[:user][:data][:id])

      green_bean_guide = second_user.plant_guides.create(
        plant_type: "Green Bean",
        seedling_days_to_transplant: 0,
        direct_seed_recommended: true,
        days_to_maturity: 45,
        days_relative_to_frost_date: 14,
        harvest_period: "season_long"
      )

      post '/api/v1/plants', params: plant5_params, headers: {
        Authorization: "Bearer #{second_user_response[:jwt]}"
      }

      # Sets the cookie to call the first user's plants instead of the second user's.
      # cookies["_session_id"] = cookie_1
      get '/api/v1/plants', headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
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
      expect(response).to be_successful

      post '/api/v1/plants', params: plant1_params, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }
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

      post '/api/v1/plants', params: plant_without_hybrid_status, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

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

      post '/api/v1/plants', params: plant_with_missing_organic_field, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to_not have_key(:error)
      expect(response).to be_successful
      expect(result[:data][:attributes][:organic]).to eq(false)
    end

    it 'will replace information with default data that the user does not provide' do
      expect(response).to be_successful

      plant = {
        plant_type: "Tomato",
        name: "Sungold",
      }
      post '/api/v1/plants', params: plant, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }
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
      post '/api/v1/plants', params: plant, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }
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
      post '/api/v1/plants', params: plant, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }
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
      post '/api/v1/plants', params: plant, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }
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
      post '/api/v1/plants', params: plant, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }
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
      post '/api/v1/plants', params: plant, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }
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
      post '/api/v1/plants', params: plant, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }
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
      post '/api/v1/plants', params: plant, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }
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

      post '/api/v1/plants', params: plant, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key(:error)

      expect(result[:error]).to include("'Plant Type' can not be blank!")
      expect(result[:error]).to include("'Days to Maturity' can not be blank!")
      expect(result[:error]).to include("'Days to Maturity' can not be blank!")
    end

    context 'creating two plants with the same name' do
      context 'with the same user' do
        context 'with different plant types'
          it 'is successful' do
            nova_tomato_params = {
              plant_type: "Tomato",
              name: "Nova",
              days_relative_to_frost_date: 14,
              days_to_maturity: 48,
              hybrid_status: :f1
            }

            post '/api/v1/plants', params: nova_tomato_params, headers: {
              Authorization: "Bearer #{@user_response[:jwt]}"
            }
            tomato_result = JSON.parse(response.body, symbolize_names: true)

            nova_raspberry_params = {
              plant_type: "Raspberry",
              name: "Nova",
              days_relative_to_frost_date: 0,
              days_to_maturity: 100,
              hybrid_status: :f1
            }

            post '/api/v1/plants', params: nova_raspberry_params, headers: {
              Authorization: "Bearer #{@user_response[:jwt]}"
            }

            result = JSON.parse(response.body, symbolize_names: true)

            expect(response).to be_successful

            expect(result[:data][:id]).to_not be nil
            expect(result[:data][:attributes][:name]).to eq(nova_raspberry_params[:name])
            expect(result[:data][:attributes][:plant_type]).to eq(nova_raspberry_params[:plant_type])
            
            get '/api/v1/plants', headers: {
              Authorization: "Bearer #{@user_response[:jwt]}"
            }
            
            users_plants_result = JSON.parse(response.body, symbolize_names: true)

            expect(users_plants_result[:data][0][:attributes][:id]).to be_an Integer
            expect(users_plants_result[:data][0][:attributes][:name]).to eq("Nova")
            expect(users_plants_result[:data][0][:attributes][:plant_type]).to eq("Tomato")

            expect(users_plants_result[:data][1][:attributes][:id]).to be_an Integer
            expect(users_plants_result[:data][1][:attributes][:name]).to eq("Nova")
            expect(users_plants_result[:data][1][:attributes][:plant_type]).to eq("Raspberry")
          end

        context 'with the same plant types' do
          it 'is unsuccessful' do
            nova_tomato_params = {
              plant_type: "Tomato",
              name: "Nova",
              days_relative_to_frost_date: 14,
              days_to_maturity: 48,
              hybrid_status: :f1
            }

            post '/api/v1/plants', params: nova_tomato_params, headers: {
              Authorization: "Bearer #{@user_response[:jwt]}"
            }
            tomato_result = JSON.parse(response.body, symbolize_names: true)

            # Try to create the same plant a second time
            post '/api/v1/plants', params: nova_tomato_params, headers: {
              Authorization: "Bearer #{@user_response[:jwt]}"
            }

            result = JSON.parse(response.body, symbolize_names: true)

            expect(response).to be_forbidden
          end

          it 'returns an informative response' do
            nova_tomato_params = {
              plant_type: "Tomato",
              name: "Nova",
              days_relative_to_frost_date: 14,
              days_to_maturity: 48,
              hybrid_status: :f1
            }

            post '/api/v1/plants', params: nova_tomato_params, headers: {
              Authorization: "Bearer #{@user_response[:jwt]}"
            }
            tomato_result = JSON.parse(response.body, symbolize_names: true)

            # Try to create the same plant a second time
            post '/api/v1/plants', params: nova_tomato_params, headers: {
              Authorization: "Bearer #{@user_response[:jwt]}"
            }

            result = JSON.parse(response.body, symbolize_names: true)

            expect(response).to be_forbidden

            expect(result[:error][0]).to eq("A #{nova_tomato_params[:plant_type]} plant named #{nova_tomato_params[:name]} already exists for #{@user.name}!")
          end
        end
      end

      context 'with different users' do
        context 'with the same plant types' do
          it 'is successful' do
            nova_tomato_params = {
              plant_type: "Tomato",
              name: "Nova",
              days_relative_to_frost_date: 14,
              days_to_maturity: 48,
              hybrid_status: :f1
            }

            post '/api/v1/plants', params: nova_tomato_params, headers: {
              Authorization: "Bearer #{@user_response[:jwt]}"
            }

            expect(response).to be_successful

            result = JSON.parse(response.body, symbolize_names: true)
            
            # Introduce a 2nd user and same plant.
            user2_params = {
              name: 'Joel Grant2',
              email: 'joel2@plantcoach.com',
              zip_code: '80121',
              password: '12345',
              password_confirmation: '12345'
            }
            post '/api/v1/users', params: user2_params

            user2_response = JSON.parse(response.body, symbolize_names: true)
            user2 = User.find_by_id(user_response[:user][:data][:id])

            user2.plant_guides.create!(
              plant_type: "Tomato",
              seedling_days_to_transplant: 49,
              direct_seed_recommended: false,
              days_to_maturity: 55,
              days_relative_to_frost_date: 14,
              harvest_period: "season_long"
            )
            
            post '/api/v1/plants', params: nova_tomato_params, headers: {
              Authorization: "Bearer #{user2_response[:jwt]}"
            }

            result2 = JSON.parse(response.body, symbolize_names: true)

            expect(response).to be_successful

            expect(result2[:data][:attributes][:user_id]).to eq(user2.id)
            expect(result2[:data][:attributes][:id]).to_not be nil

            # Introduce a 3rd user and same plant.
            user3_params = {
              name: 'Joel Grant3',
              email: 'joel3@plantcoach.com',
              zip_code: '80121',
              password: '12345',
              password_confirmation: '12345'
            }
            post '/api/v1/users', params: user3_params

            user3_response = JSON.parse(response.body, symbolize_names: true)
            user3 = User.find_by_id(user3_response[:user][:data][:id])

            user3.plant_guides.create!(
              plant_type: "Tomato",
              seedling_days_to_transplant: 49,
              direct_seed_recommended: false,
              days_to_maturity: 55,
              days_relative_to_frost_date: 14,
              harvest_period: "season_long"
            )

            post '/api/v1/plants', params: nova_tomato_params, headers: {
              Authorization: "Bearer #{user3_response[:jwt]}"
            }

            expect(response).to be_successful
            
            result3 = JSON.parse(response.body, symbolize_names: true)

            expect(result3[:data][:attributes][:user_id]).to eq(user3.id)
            expect(result3[:data][:attributes][:id]).to_not be nil
          end
        end
      end
    end
  end

  describe 'GET /plants/plant_id' do
    it 'returns the unique plant record that belongs to the user' do
      ActiveRecord::Base.skip_callbacks = false
      expect(response).to be_successful

      plant = {
        plant_type: "Tomato",
        name: "Sakura",
      }
      post '/api/v1/plants', params: plant, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      expect(response).to be_successful

      plant_result = JSON.parse(response.body, symbolize_names: true)
      plant_id = plant_result[:data][:attributes][:id]

      get "/api/v1/plants/#{plant_id}", headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:attributes][:name]).to eq("Sakura")
      expect(result[:data][:attributes][:plant_type]).to eq("Tomato")
      expect(result[:data][:attributes][:id]).to eq(plant_id)
    end

    it 'returns an error response when the ID is wrong' do
      ActiveRecord::Base.skip_callbacks = false
      expect(response).to be_successful

      plant = {
        plant_type: "Tomato",
        name: "Sakura",
      }
      post '/api/v1/plants', params: plant, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      expect(response).to be_successful

      plant_result = JSON.parse(response.body, symbolize_names: true)
      non_existent_id = 203948

      get "/api/v1/plants/#{non_existent_id}", headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:error]).to eq("The plant can not be found!")
    end
  end

  describe 'PATCH /plants' do
    it 'updates an existing plant with new attributes' do
      expect(response).to be_successful

      patch "/api/v1/plants/#{plant1_object.id}", params: { days_to_maturity: 61 }, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:attributes][:days_to_maturity]).to eq(61)
    end
  end

  describe 'DELETE /plants' do
    it 'removes a plant from the list of available plants' do
      expect(response).to be_successful

      delete "/api/v1/plants/#{plant3_object.id}", headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(Plant.find_by(id: plant3_object.id)).to be nil
    end

    it 'returns an error if the plant can not be found' do
      expect(response).to be_successful

      delete "/api/v1/plants/999999", headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:error]).to eq("Something happened!")
    end
  end
end
