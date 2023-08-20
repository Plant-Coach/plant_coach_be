require 'rails_helper'

RSpec.describe 'Plants Waiting To Be Started API Endpoint', :vcr do
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
  end

  describe 'GET /plants_waiting_to_be_started' do
    it 'returns all the plants that have been added to the users garden but have not been transplanted or seeded' do
      # body = {
      #   name: 'Joel Grant',
      #   email: 'joel@plantcoach.com',
      #   zip_code: '80121',
      #   password: '12345',
      #   password_confirmation: '12345'
      # }
      # post '/api/v1/users', params: body
      # user_response = JSON.parse(response.body, symbolize_names: true)
      # user = User.find_by_id(user_response[:user][:data][:id])

      # While a function of the app is to auto-provide missing attributes of a
      # new plant, that does not seem to work quickly enough while RSpec is running tests.
      # Therefore, they need to be explicitly assigned as this causes validation errors.
      # It is also not the purpose of this test.
      plant1_object = @user.plants.create!(
        name: "Sungold",
        plant_type: "Tomato",
        days_relative_to_frost_date: 14,
        days_to_maturity: 60,
        hybrid_status: 1
      )
      plant2_object = @user.plants.create!(
        name: "Jalafuego",
        plant_type: "Pepper",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: 1
      )
      plant3_object = @user.plants.create!(
        name: "Rosa Bianca",
        plant_type: "Eggplant",
        days_relative_to_frost_date: 14,
        days_to_maturity: 70,
        hybrid_status: 1
      )

      post '/api/v1/garden_plants', params: {
        plant_id: plant1_object.id,
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: :open_pollinated,
        organic: false,
        actual_seed_sewing_date: nil,
        plant_start_method: :indirect_sew,
        planting_status: "not_started"
        }, headers: {
          Authorization: "Bearer #{@user_response[:jwt]}"
        }

        post '/api/v1/garden_plants', params: {
          plant_id: plant2_object.id,
          name: "Jalafuego",
          plant_type: "Pepper",
          days_relative_to_frost_date: 14,
          days_to_maturity: 65,
          hybrid_status: :open_pollinated,
          organic: false,
          plant_start_method: :indirect_sew,
          actual_seed_sewing_date: nil,
          planting_status: "not_started"
          }, headers: {
            Authorization: "Bearer #{@user_response[:jwt]}"
          }

        post '/api/v1/garden_plants', params: {
          plant_id: plant3_object.id,
          name: "Rosa Bianca",
          plant_type: "Eggplant",
          days_relative_to_frost_date: 14,
          days_to_maturity: 70,
          hybrid_status: :open_pollinated,
          organic: false,
          plant_start_method: :indirect_sew,
          actual_seed_sewing_date: nil,
          planting_status: "not_started"
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
        expect(plant[:attributes][:planting_status]).to eq "not_started"
        expect(plant[:attributes][:actual_seed_actual_seed_sewing_date]).to be nil
      end
    end
  end
end
