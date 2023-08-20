require 'rails_helper'

RSpec.describe 'Garden Plants API Endpoint', :vcr do
  before(:each) do
    ActiveRecord::Base.skip_callbacks = false

    # @user = User.create(
    #   name: 'Joel Grant',
    #   email: 'joel@plantcoach.com',
    #   zip_code: '80121',
    #   password: '12345',
    #   password_confirmation: '12345'
    # )

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
      days_to_maturity: 45,
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


  #   body = {
  #   name: 'Joel Grant',
  #   email: 'joel@plantcoach.com',
  #   zip_code: '80121',
  #   password: '12345',
  #   password_confirmation: '12345'
  # }

    # post '/api/v1/users', params: body
    # binding.pry;
  end

  # let(:body) {{
  #   name: 'Joel Grant',
  #   email: 'joel@plantcoach.com',
  #   zip_code: '80121',
  #   password: '12345',
  #   password_confirmation: '12345'
  # }}
# binding.pry;
  # let(:user_response) { JSON.parse(response.body, symbolize_names: true) }
  # let(:user) { User.find_by_id(user_response[:user][:data][:id]) }

  let(:plant1_object) { @user.plants.create!(
    plant_type: "Tomato",
    name: "Sungold",
    days_relative_to_frost_date: 14,
    days_to_maturity: 54,
    hybrid_status: 1,
    organic: false
  ) }

  let(:plant2_object) { @user.plants.create!(
    plant_type: "Pepper",
    name: "Jalafuego",
    days_relative_to_frost_date: 14,
    days_to_maturity: 65,
    hybrid_status: 1,
    organic: false
  ) }

  let(:plant3_object) { @user.plants.create!(
    plant_type: "Basil",
    name: "Thai Towers"
  ) }

  let(:plant4_object) { @user.plants.create!(
    plant_type: "Sprouting Broccoli",
    name: "Di Cicco"
  ) }

  let(:plant5_object) { @user.plants.create!(
    plant_type: "Cucumber",
    name: "Corinto"
  ) }

  let(:plant6_object) { @user.plants.create!(
    plant_type: "Carrot",
    name: "SugarSnax",
    days_relative_to_frost_date: -30,
    days_to_maturity: 60
  ) }

  let(:plant7_object) { @user.plants.create!(
    plant_type: "Romaine Lettuce",
    name: "Coastal Star"
  ) }
  let(:plant8_object) { @user.plants.create!(
    plant_type: "Cilantro",
    name: "Santo"
  ) }

  describe 'POST garden plants' do
    context 'starting a plant from seed' do
      context 'outside' do
        context 'right now' do
          # This only works when both the seed-start date and the actual transplant date are provided.
          # Only the actual_seed_sewing_date is necessary if the rails dirty call backs were working.
          it 'creates a garden plant that has an updated planting status' do
            post '/api/v1/garden_plants', params: {
              plant_id: plant1_object.id,
              plant_start_method: :direct_sew,
              actual_seed_sewing_date: Date.today,
              planting_status: "direct_sewn_outside"
            },
            headers: {
              Authorization: "Bearer #{@user_response[:jwt]}"
          }
            result = JSON.parse(response.body, symbolize_names: true)

            expect(response).to be_successful

            expect(result[:data][:attributes][:planting_status]).to eq("direct_sewn_outside")
            expect(result[:data][:attributes][:actual_seed_sewing_date].to_date).to eq(Date.today)
            expect(result[:data][:attributes][:recommended_transplant_date]).to be nil
            expect(result[:data][:attributes][:plant_id]).to_not be nil
          end

          it 'provides an expected date range that the plant will have for a period of harvest' do
            post '/api/v1/garden_plants', params: {
              plant_id: plant1_object.id,
              plant_start_method: :direct_sew,
              actual_seed_sewing_date: Date.today,
              planting_status: "transplanted_outside"
            },
            headers: {
              Authorization: "Bearer #{@user_response[:jwt]}"
            }

            result = JSON.parse(response.body, symbolize_names: true)

            expect(response).to be_successful

            transplant_date = @user.spring_frost_date.to_date + plant1_object.days_relative_to_frost_date
            days_to_maturity = plant1_object.days_to_maturity

            harvest_start = transplant_date + days_to_maturity
            harvest_finish = @user.fall_frost_date.to_date

            expect(result[:data][:attributes][:harvest_start].to_date).to eq(harvest_start)
            expect(result[:data][:attributes][:harvest_finish].to_date).to eq(harvest_finish)
          end

          it 'provides a harvest range that is shorter for limited-harvest plants' do
            post '/api/v1/garden_plants', params: {
              plant_id: plant3_object.id,
              plant_start_method: :direct_sew,
              actual_seed_sewing_date: "2023-05-20",
              plant_type: "Basil"
            },
            headers: {
              Authorization: "Bearer #{@user_response[:jwt]}"
            }

            result = JSON.parse(response.body, symbolize_names: true)

            expect(response).to be_successful

            transplant_date = @user.spring_frost_date.to_date + plant3_object.days_relative_to_frost_date
            days_to_maturity = plant3_object.days_to_maturity

            harvest_start = transplant_date + days_to_maturity
            harvest_finish = harvest_start + 21

            expect(result[:data][:attributes][:harvest_start].to_date).to eq(harvest_start)
            expect(result[:data][:attributes][:harvest_finish].to_date).to eq(harvest_finish)
          end
        end

        context 'in the future' do
          it 'creates a garden plant that has the information needed to be planted later' do
            post '/api/v1/garden_plants', params: {
              plant_id: plant1_object.id,
              plant_start_method: :direct_sew
            },
            headers: {
              Authorization: "Bearer #{@user_response[:jwt]}"
            }

            result = JSON.parse(response.body, symbolize_names: true)

            expect(response).to be_successful

            expect(result[:data][:attributes][:planting_status]).to eq("not_started")
            expect(result[:data][:attributes][:recommended_seed_sewing_date]).to_not be nil
          end
        end
      end

      context 'inside' do
        context 'right now' do
          it 'creates new plant that the user will be planting' do
            post '/api/v1/garden_plants', params: {
              plant_id: plant1_object.id,
              plant_start_method: :indirect_sew,
              actual_seed_sewing_date: Date.today
              },
              headers: {
                Authorization: "Bearer #{@user_response[:jwt]}"
              }

            result = JSON.parse(response.body, symbolize_names: true)
            new_plant = GardenPlant.last

            expect(response).to be_successful

            expect(new_plant.id).to eq(result[:data][:id].to_i)

            expect(result).to be_a Hash
            expect(result).to have_key(:data)

            expect(result[:data]).to be_a Hash

            
            expect(result[:data][:attributes][:planting_status]).to eq("started_indoors")

            expect(result[:data][:attributes]).to have_key(:recommended_transplant_date)
            expect(result[:data][:attributes]).to have_key(:planting_status)
            expect(result[:data][:attributes]).to have_key(:direct_seed_recommended)
            expect(result[:data][:attributes]).to have_key(:recommended_seed_sewing_date)
            expect(result[:data][:attributes]).to have_key(:actual_seed_sewing_date)
            expect(result[:data][:attributes]).to have_key(:seedling_days_to_transplant)
          end
          #likely to delete
          it 'will return a json error message if there was a problem' do
            post '/api/v1/garden_plants', params: { plant_id: 99999999999}, headers: {
              Authorization: "Bearer #{@user_response[:jwt]}"
            }

            result = JSON.parse(response.body, symbolize_names: true)

            expect(response.status).to eq(400)

            expect(result).to have_key(:error)
            expect(result[:error]).to eq("There was a problem finding a plant to copy!")
          end
        end
      

        context 'in the future' do
          it 'creates a plant with the data needed to time its future transplanting' do
            post '/api/v1/garden_plants', params: {
              plant_id: plant1_object.id,
              plant_start_method: :indirect_sew
              }, headers: {
                Authorization: "Bearer #{@user_response[:jwt]}"
              }

              result = JSON.parse(response.body, symbolize_names: true)

              expect(result[:data][:attributes][:planting_status]).to eq("not_started")
              expect(result[:data][:attributes][:recommended_seed_sewing_date].to_date).to be_a Date
              expect(result[:data][:attributes][:plant_start_method]).to eq("indirect_sew")
              expect(result[:data][:attributes][:recommended_transplant_date].to_date).to be_a Date
          end

          it 'establishes the plants harvest period and harvest dates for a season-long-harvest plant such as a tomato' do
            post '/api/v1/garden_plants', params: {
              plant_id: plant1_object.id,
              plant_start_method: :indirect_sew
              }, headers: {
                Authorization: "Bearer #{@user_response[:jwt]}"
              }

              result = JSON.parse(response.body, symbolize_names: true)

              expect(result[:data][:attributes][:planting_status]).to eq("not_started")
              expect(result[:data][:attributes][:recommended_seed_sewing_date].to_date).to be_a Date
              expect(result[:data][:attributes][:plant_start_method]).to eq("indirect_sew")
              expect(result[:data][:attributes][:recommended_transplant_date].to_date).to be_a Date

              expect(result[:data][:attributes]).to have_key(:harvest_period)
              expect(result[:data][:attributes]).to have_key(:harvest_start)
              expect(result[:data][:attributes]).to have_key(:harvest_finish)

              expected_harvest_start = result[:data][:attributes][:recommended_transplant_date].to_date + 54
              expected_harvest_finish = @user.fall_frost_date

              expect(result[:data][:attributes][:harvest_period]).to eq("season_long")
              expect(result[:data][:attributes][:harvest_start].to_date).to eq(expected_harvest_start)
              expect(result[:data][:attributes][:harvest_finish].to_date).to eq(expected_harvest_finish.to_date)
          end

          it 'establishes the plants harvest period and harvest dates for a four-week long harvested plant such as sprouting broccoli' do
            post '/api/v1/garden_plants', params: {
              plant_id: plant4_object.id,
              plant_start_method: :indirect_sew
              }, headers: {
                Authorization: "Bearer #{@user_response[:jwt]}"
              }

              result = JSON.parse(response.body, symbolize_names: true)

              expect(result[:data][:attributes][:planting_status]).to eq("not_started")
              expect(result[:data][:attributes][:recommended_seed_sewing_date].to_date).to be_a Date
              expect(result[:data][:attributes][:plant_start_method]).to eq("indirect_sew")

              expect(result[:data][:attributes]).to have_key(:harvest_period)
              expect(result[:data][:attributes]).to have_key(:harvest_start)
              expect(result[:data][:attributes]).to have_key(:harvest_finish)

              four_weeks_in_days = 4 * 7
              expected_harvest_start = result[:data][:attributes][:recommended_transplant_date].to_date + 45
              expected_harvest_finish = expected_harvest_start + four_weeks_in_days

              expect(result[:data][:attributes][:harvest_period]).to eq("four_week")
              expect(result[:data][:attributes][:harvest_start].to_date).to eq(expected_harvest_start)
              expect(result[:data][:attributes][:harvest_finish].to_date).to eq(expected_harvest_finish.to_date)
          end

          it 'establishes the plants harvest period and harvest dates for a three-week long harvested plant such as a cucumber' do
            post '/api/v1/garden_plants', params: {
              plant_id: plant3_object.id,
              plant_start_method: :indirect_sew
              }, headers: {
                Authorization: "Bearer #{@user_response[:jwt]}"
              }

              result = JSON.parse(response.body, symbolize_names: true)

              expect(result[:data][:attributes][:planting_status]).to eq("not_started")
              expect(result[:data][:attributes][:recommended_seed_sewing_date].to_date).to be_a Date
              expect(result[:data][:attributes][:plant_start_method]).to eq("indirect_sew")

              expect(result[:data][:attributes]).to have_key(:harvest_period)
              expect(result[:data][:attributes]).to have_key(:harvest_start)
              expect(result[:data][:attributes]).to have_key(:harvest_finish)

              three_weeks_in_days = 3 * 7
              expected_harvest_start = result[:data][:attributes][:recommended_transplant_date].to_date + plant3_object.days_to_maturity
              expected_harvest_finish = expected_harvest_start + three_weeks_in_days

              expect(result[:data][:attributes][:harvest_period]).to eq("three_week")
              expect(result[:data][:attributes][:harvest_start].to_date).to eq(expected_harvest_start)
              expect(result[:data][:attributes][:harvest_finish].to_date).to eq(expected_harvest_finish)
          end

          it 'establishes the plants harvest period and harvest dates for a two-week long harvested plant such as cilantro' do
            post '/api/v1/garden_plants', params: {
              plant_id: plant8_object.id,
              plant_start_method: :indirect_sew
              }, headers: {
                Authorization: "Bearer #{@user_response[:jwt]}"
              }

              result = JSON.parse(response.body, symbolize_names: true)

              expect(result[:data][:attributes][:planting_status]).to eq("not_started")
              expect(result[:data][:attributes][:recommended_seed_sewing_date].to_date).to be_a Date
              expect(result[:data][:attributes][:plant_start_method]).to eq("indirect_sew")

              expect(result[:data][:attributes]).to have_key(:harvest_period)
              expect(result[:data][:attributes]).to have_key(:harvest_start)
              expect(result[:data][:attributes]).to have_key(:harvest_finish)

              two_weeks_in_days = 2 * 7
              expected_harvest_start = result[:data][:attributes][:recommended_transplant_date].to_date + plant8_object.days_to_maturity
              expected_harvest_finish = expected_harvest_start + two_weeks_in_days

              expect(result[:data][:attributes][:harvest_period]).to eq("two_week")
              expect(result[:data][:attributes][:harvest_start].to_date).to eq(expected_harvest_start)
              expect(result[:data][:attributes][:harvest_finish].to_date).to eq(expected_harvest_finish)
          end

          it 'establishes the plants harvest period and harvest dates for a 1-week long harvested plant such as carrots' do
            post '/api/v1/garden_plants', params: {
              plant_id: plant6_object.id,
              plant_start_method: :indirect_sew
              }, headers: {
                Authorization: "Bearer #{@user_response[:jwt]}"
              }

              result = JSON.parse(response.body, symbolize_names: true)

              expect(result[:data][:attributes][:planting_status]).to eq("not_started")
              expect(result[:data][:attributes][:recommended_seed_sewing_date].to_date).to be_a Date
              expect(result[:data][:attributes][:plant_start_method]).to eq("indirect_sew")
              expect(result[:data][:attributes][:recommended_transplant_date].to_date).to be_a Date

              expect(result[:data][:attributes]).to have_key(:harvest_period)
              expect(result[:data][:attributes]).to have_key(:harvest_start)
              expect(result[:data][:attributes]).to have_key(:harvest_finish)

              one_week_in_days = 7
              expected_harvest_start = result[:data][:attributes][:recommended_transplant_date].to_date + plant6_object.days_to_maturity
              expected_harvest_finish = expected_harvest_start + one_week_in_days

              expect(result[:data][:attributes][:harvest_period]).to eq("one_week")
              expect(result[:data][:attributes][:harvest_start].to_date).to eq(expected_harvest_start)
              expect(result[:data][:attributes][:harvest_finish].to_date).to eq(expected_harvest_finish)
          end

          it 'establishes the plants harvest period and harvest dates for a one-time harvested plant such as a head of lettuce' do
            post '/api/v1/garden_plants', params: {
              plant_id: plant7_object.id,
              plant_start_method: :indirect_sew
              }, headers: {
                Authorization: "Bearer #{@user_response[:jwt]}"
              }

              result = JSON.parse(response.body, symbolize_names: true)

              expect(result[:data][:attributes][:planting_status]).to eq("not_started")
              expect(result[:data][:attributes][:recommended_seed_sewing_date].to_date).to be_a Date
              expect(result[:data][:attributes][:plant_start_method]).to eq("indirect_sew")
              expect(result[:data][:attributes][:recommended_transplant_date].to_date).to be_a Date

              expect(result[:data][:attributes]).to have_key(:harvest_period)
              expect(result[:data][:attributes]).to have_key(:harvest_start)
              expect(result[:data][:attributes]).to have_key(:harvest_finish)

              expected_harvest_start = result[:data][:attributes][:recommended_transplant_date].to_date + plant7_object.days_to_maturity
              expected_harvest_finish = expected_harvest_start

              expect(result[:data][:attributes][:harvest_period]).to eq("one_time")
              expect(result[:data][:attributes][:harvest_start].to_date).to eq(expected_harvest_start)
              expect(result[:data][:attributes][:harvest_finish].to_date).to eq(expected_harvest_finish)
          end
        end
      end
    end

    context 'starting as a plant' do
      context 'right now' do
        # This could now be re-written to provide an error message that helps the fe development rather than for the end user.
        xit 'creates a garden plant that is updated with information relevant to being place outside' do
          post '/api/v1/garden_plants', params: {
            plant_id: plant2_object.id,
            # This...
            actual_transplant_date: Date.today
          }, headers: {
            Authorization: "Bearer #{@user_response[:jwt]}"
          }
          
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:data][:attributes][:planting_status]).to eq("transplanted_outside")

          expect(result[:data][:attributes][:plant_start_method]).to eq("not_applicable")
          expect(result[:data][:attributes][:actual_seed_sewing_date]).to be nil
          expect(result[:data][:attributes][:recommended_seed_sewing_date].to_date).to be_a Date
          expect(result[:data][:attributes][:direct_seed_recommended]).to_not be nil
        end
      end

      context 'in the future' do
        it 'creates a garden plant that is scheduled with a planting in the future' do
          post '/api/v1/garden_plants', params: {
            plant_id: plant2_object.id,

          }, headers: {
            Authorization: "Bearer #{@user_response[:jwt]}"
          }
          
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:data][:attributes][:planting_status]).to eq("not_started")
          expect(result[:data][:attributes][:actual_seed_sewing_date]).to be nil
          expect(result[:data][:attributes][:recommended_seed_sewing_date]).to_not be nil
        end
      end
    end
  end

  describe 'GET /garden_plants' do
    it 'retrieves an array of the plants that belong to the user' do
      unused_plant = @user.plants.create!(
        plant_type: "Something else",
        name: "A plant you shouldn't see",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: 1,
        organic: false
      )
      plant1_object.garden_plants.create!(
        {
        plant_start_method: :indirect_sew,
        planting_status: "not_started",
        }
      )
      plant2_object.garden_plants.create!(
        {
        plant_start_method: :indirect_sew,
        planting_status: "not_started",
        }
      )

      get '/api/v1/garden_plants', headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a Hash
      expect(result[:data]).to be_an Array

      expect(result[:data].count).to eq(2)
      result[:data].each do |plant|
        expect(plant[:attributes][:plant][:name]).to be_a String
        expect(plant[:attributes][:plant][:plant_type]).to be_a String
        expect(plant[:attributes][:plant][:days_to_maturity]).to be_a Integer
        expect(plant[:attributes][:plant][:hybrid_status]).to be_a String
        expect(plant[:attributes][:plant][:organic]).to be_in [true, false]
        expect(plant[:attributes][:plant][:days_relative_to_frost_date]).to be_a Integer
        expect(plant[:attributes][:plant][:user_id]).to be_a Integer
        expect(plant[:attributes][:plant][:harvest_period]).to be_a String
        expect(plant[:attributes][:recommended_transplant_date]).to be_a String
        expect(plant[:attributes][:plant_start_method]).to be_a String
        expect(plant[:attributes][:recommended_seed_sewing_date]).to be_a String
        expect(plant[:attributes][:seedling_days_to_transplant]).to be_a Integer
        expect(plant[:attributes][:harvest_start]).to be_a String
        expect(plant[:attributes][:harvest_finish]).to be_a String
        expect(plant[:attributes][:harvest_period]).to be_a String
      end
    end
  end

  describe 'PATCH /garden_plants' do
    context 'when updating a GardenPlants planting status' do
      describe 'from not started to started indoors' do
        it 'returns will update the planting status and the seed-sewing date' do
          post '/api/v1/garden_plants', params: {
            plant_id: plant1_object.id,
            actual_seed_sewing_date: nil,
            plant_start_method: :indirect_sew,
            planting_status: "not_started"
          }, headers: {
            Authorization: "Bearer #{@user_response[:jwt]}"
          }

          new_garden_plant = @user.plants.find_by_id(plant1_object.id).garden_plants.first

          patch "/api/v1/garden_plants/#{new_garden_plant.id}", params: {
            planting_status: "started_indoors",
            actual_seed_sewing_date: Date.today
          }, headers: {
            Authorization: "Bearer #{@user_response[:jwt]}"
          }
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:data][:attributes][:planting_status]).to eq("started_indoors")
          expect(result[:data][:attributes][:actual_seed_sewing_date]).to_not be nil
          expect(result[:data][:attributes][:actual_seed_sewing_date].to_date).to eq(Date.today)
        end

        it 'returns a meaningful error response if the frontend doesnt provide...' do
          post '/api/v1/garden_plants', params: {
            plant_id: plant1_object.id,
            actual_seed_sewing_date: nil,
            plant_start_method: :indirect_sew,
            planting_status: :not_started
          }, headers: {
            Authorization: "Bearer #{@user_response[:jwt]}"
          }

          new_garden_plant = @user.plants.find_by_id(plant1_object.id).garden_plants.first

          patch "/api/v1/garden_plants/#{new_garden_plant.id}", params: {
            planting_status: :started_indoors
          }, headers: {
            Authorization: "Bearer #{@user_response[:jwt]}"
          }
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:error]).to eq("You must specify a seed-sewing date!")
        end
      end

      describe 'from Started Indoors to Transplanted Outside' do
        it 'will update the planting status and the actual transplant date' do
          post '/api/v1/garden_plants', params: {
            plant_id: plant1_object.id,
            actual_seed_sewing_date: Date.yesterday,
            plant_start_method: :indirect_sew,
            planting_status: :started_indoors
          }, headers: {
            Authorization: "Bearer #{@user_response[:jwt]}"
          }

          new_garden_plant = @user.plants.find_by_id(plant1_object.id).garden_plants.first

          patch "/api/v1/garden_plants/#{new_garden_plant.id}", params: {
            planting_status: :transplanted_outside,
            actual_transplant_date: Date.today
          }, headers: {
            Authorization: "Bearer #{@user_response[:jwt]}"
          }
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:data][:attributes][:planting_status]).to eq("transplanted_outside")
          expect(result[:data][:attributes][:actual_transplant_date]).to_not be nil
          expect(result[:data][:attributes][:actual_transplant_date].to_date).to eq(Date.today)
        end

        it 'returns a meaningful error response if the frontend doesnt provide...' do
          post '/api/v1/garden_plants', params: {
            plant_id: plant1_object.id,
            actual_seed_sewing_date: nil,
            plant_start_method: :indirect_sew,
            planting_status: "not_started"
          }, headers: {
            Authorization: "Bearer #{@user_response[:jwt]}"
          }

          new_garden_plant = @user.plants.find_by_id(plant1_object.id).garden_plants.first

          patch "/api/v1/garden_plants/#{new_garden_plant.id}", params: {
            planting_status: :transplanted_outside
          }, headers: {
            Authorization: "Bearer #{@user_response[:jwt]}"
          }
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:error]).to eq("You must specify a transplant date!")
        end
      end
      
      describe 'from not started to transplanted outside' do
        it 'will return a meaningful error response if the frontend doesnt provide an actual transplant date' do
          post '/api/v1/garden_plants', params: {
            plant_id: plant1_object.id,
            actual_seed_sewing_date: nil,
            plant_start_method: :indirect_sew,
            planting_status: "not_started"
          }, headers: {
            Authorization: "Bearer #{@user_response[:jwt]}"
          }

          new_garden_plant = @user.plants.find_by_id(plant1_object.id).garden_plants.first

          patch "/api/v1/garden_plants/#{new_garden_plant.id}", params: {
            planting_status: "transplanted_outside"
          }, headers: {
            Authorization: "Bearer #{@user_response[:jwt]}"
          }
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:error]).to eq("You must specify a transplant date!")
        end

        it 'will only update the object when an actual_transplant_date is passed' do
          post '/api/v1/garden_plants', params: {
            plant_id: plant1_object.id,
            actual_seed_sewing_date: nil,
            plant_start_method: :indirect_sew,
            planting_status: "not_started"
          }, headers: {
            Authorization: "Bearer #{@user_response[:jwt]}"
          }

          new_garden_plant = @user.plants.find_by_id(plant1_object.id).garden_plants.first

          patch "/api/v1/garden_plants/#{new_garden_plant.id}", params: {
            planting_status: "transplanted_outside", 
            actual_transplant_date: Date.today
          }, headers: {
            Authorization: "Bearer #{@user_response[:jwt]}"
          }
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:data][:attributes][:planting_status]).to eq("transplanted_outside")
          expect(result[:data][:attributes][:actual_transplant_date].to_date).to eq(Date.today)
        end
      end

      describe 'from Not Started to Direct Seeded Outside' do
        it 'will update the status and transplant date' do
          post '/api/v1/garden_plants', params: {
            plant_id: plant1_object.id,
            actual_seed_sewing_date: nil,
            plant_start_method: :direct_sew,
            planting_status: "not_started"
          }, headers: {
            Authorization: "Bearer #{@user_response[:jwt]}"
          }

          new_garden_plant = @user.plants.find_by_id(plant1_object.id).garden_plants.first

          patch "/api/v1/garden_plants/#{new_garden_plant.id}", params: {
            planting_status: "direct_sewn_outside", 
            actual_seed_sewing_date: Date.today
          }, headers: {
            Authorization: "Bearer #{@user_response[:jwt]}"
          }
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:data][:attributes][:planting_status]).to eq("direct_sewn_outside")
          expect(result[:data][:attributes][:actual_seed_sewing_date].to_date).to eq(Date.today)
          expect(result[:data][:attributes][:actual_transplant_date]).to be nil
          # expect(result[:data][:attributes][:actual_seed_sewing_date].to_date).to eq(Date.today)
        end

        it 'will return an error if the necessary information was not provided' do
          post '/api/v1/garden_plants', params: {
            plant_id: plant1_object.id,
            actual_seed_sewing_date: nil,
            plant_start_method: :direct_sew,
            planting_status: "not_started"
          }, headers: {
            Authorization: "Bearer #{@user_response[:jwt]}"
          }

          new_garden_plant = @user.plants.find_by_id(plant1_object.id).garden_plants.first

          patch "/api/v1/garden_plants/#{new_garden_plant.id}", params: {
            planting_status: "direct_sewn_outside"
          }, headers: {
            Authorization: "Bearer #{@user_response[:jwt]}"
          }
          result = JSON.parse(response.body, symbolize_names: true)
          
          expect(result[:error]).to eq("You must specify a seed-sewing date!")
        end
      end
    end

    it 'allows the user to add an actual planting date to an existing garden_plant' do
      post '/api/v1/garden_plants', params: {
        plant_id: plant1_object.id,
        actual_seed_sewing_date: nil,
        plant_start_method: :indirect_sew,
        planting_status: "not_started"
      }, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)
      garden_plant = @user.plants.find_by_id(plant1_object.id).garden_plants.first

      expect(response).to be_successful

      expect(garden_plant.id).to eq(result[:data][:id].to_i)

      expect(result).to be_a Hash
      expect(result).to have_key(:data)

      expect(result[:data]).to be_a Hash

      expect(result[:data][:attributes]).to have_key(:recommended_transplant_date)
      expect(result[:data][:attributes]).to have_key(:planting_status)
      expect(result[:data][:attributes][:planting_status]).to eq("not_started")

      expect(result[:data][:attributes]).to have_key(:direct_seed_recommended)
      expect(result[:data][:attributes]).to have_key(:recommended_seed_sewing_date)
      expect(result[:data][:attributes]).to have_key(:actual_seed_sewing_date)
      expect(result[:data][:attributes]).to have_key(:seedling_days_to_transplant)

      patch "/api/v1/garden_plants/#{garden_plant.id}", params: {
        actual_seed_sewing_date: Date.yesterday
        }, headers: {
          Authorization: "Bearer #{@user_response[:jwt]}"
        }

      patch_result = JSON.parse(response.body, symbolize_names: true)

      expect(patch_result[:data][:attributes][:actual_seed_sewing_date].to_date).to eq(Date.yesterday)
      expect(patch_result[:data][:attributes][:recommended_transplant_date]).to eq((Date.yesterday + @tomato_guide.seedling_days_to_transplant).to_s)
    end

    it 'will add a transplant date to the garden_plant object when giving a plant a transplant date' do
      post '/api/v1/garden_plants', params: {
        plant_id: plant1_object.id,
        actual_seed_sewing_date: Date.today,
        plant_start_method: :indirect_sew,
        planting_status: "started_indoors"
        }, headers: {
          Authorization: "Bearer #{@user_response[:jwt]}"
        }

      result = JSON.parse(response.body, symbolize_names: true)
      garden_plant = @user.plants.find_by_id(plant1_object.id).garden_plants.first

      expect(response).to be_successful

      expect(garden_plant.id).to eq(result[:data][:id].to_i)

      expect(result).to be_a Hash
      expect(result).to have_key(:data)

      expect(result[:data]).to be_a Hash

      expect(result[:data][:attributes]).to have_key(:recommended_transplant_date)
      expect(result[:data][:attributes]).to have_key(:planting_status)
      expect(result[:data][:attributes][:planting_status]).to eq("started_indoors")

      patch "/api/v1/garden_plants/#{garden_plant.id}", params: { actual_transplant_date: Date.today }, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      patch_result = JSON.parse(response.body, symbolize_names: true)

      expect(patch_result[:data][:attributes]).to have_key(:actual_transplant_date)
      expect(patch_result[:data][:attributes][:actual_transplant_date]).to eq(Date.today.to_s)
    end
  end

  describe 'DELETE /garden_plants' do
    it 'removes the plant from the users list of plants' do
      garden_plant = plant1_object.garden_plants.create!(
        {
        plant_start_method: :indirect_sew,
        planting_status: "not_started",
        }
      )

      delete "/api/v1/garden_plants/#{garden_plant.id}", headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:status]).to eq("success")
    end
  end
end
