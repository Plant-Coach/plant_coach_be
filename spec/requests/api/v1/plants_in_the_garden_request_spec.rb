require 'rails_helper'

RSpec.describe 'Plants In The Garden API Endpoint', :vcr do
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

  user_response = JSON.parse(response.body, symbolize_names: true)
  @user = User.find_by_id(user_response[:user][:data][:id])

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

  # let(:body) {{
  #   name: 'Joel Grant',
  #   email: 'joel@plantcoach.com',
  #   zip_code: '80121',
  #   password: '12345',
  #   password_confirmation: '12345'
  # }}

  # let(:user_response) { JSON.parse(response.body, symbolize_names: true) }
  # let(:user) { User.find_by_id(user_response[:user][:data][:id]) }

  let(:plant) { @user.plants.create!(
    name: "Sungold",
    plant_type: "Tomato",
    days_relative_to_frost_date: 14,
    days_to_maturity: 60,
    hybrid_status: 1
  ) }
  let(:plant1)  { @user.plants.create!(
    name: "Jalafuego",
    plant_type: "Pepper",
    days_relative_to_frost_date: 14,
    days_to_maturity: 65,
    hybrid_status: 1
  ) }
  let(:plant2) { @user.plants.create!(
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
        name: "Sungold",
        plant_type: "Tomato",
        days_relative_to_frost_date: 14,
        days_to_maturity: 60,
        hybrid_status: :open_pollinated,
        organic: false,
        plant_start_method: :indirect_sew,
        actual_seed_sewing_date: Date.yesterday,
        planting_status: "started_indoors"
        }

      post '/api/v1/garden_plants', params: {
        plant_id: plant1.id,
        name: "Jalafuego",
        plant_type: "Pepper",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: :open_pollinated,
        organic: false,
        plant_start_method: :indirect_sew,
        actual_seed_sewing_date: Date.yesterday,
        planting_status: "started_indoors"
        }

      post '/api/v1/garden_plants', params: {
        plant_id: plant2.id,
        name: "Rosa Bianca",
        plant_type: "Eggplant",
        days_relative_to_frost_date: 14,
        days_to_maturity: 70,
        hybrid_status: :open_pollinated,
        organic: false,
        plant_start_method: :indirect_sew,
        actual_seed_sewing_date: Date.yesterday,
        planting_status: "started_indoors"
        }

      last_garden_plant = GardenPlant.last

      # Only one of the 3 plants are now planted in the ground - we expect one below.
      patch "/api/v1/garden_plants/#{last_garden_plant.id}", params: {
        actual_transplant_date: Date.today,
        planting_status: "transplanted_outside"
        }

      get '/api/v1/plants_in_the_garden'
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data].count).to eq(1)

      result[:data].each do |plant|
        expect(plant[:attributes][:actual_transplant_date]).to_not be nil
        expect(plant[:attributes][:planting_status]).to eq "transplanted_outside"
      end
    end
  end
end
