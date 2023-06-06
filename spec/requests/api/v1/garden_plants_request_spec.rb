require 'rails_helper'

RSpec.describe 'Garden Plants API Endpoint', :vcr do
  before(:each) do
    ActiveRecord::Base.skip_callbacks = false
    @tomato_seed = SeedDefaultData.create!(
      plant_type: "Tomato",
      days_to_maturity: 55,
      seedling_days_to_transplant: 49,
      days_relative_to_frost_date: 14,
      direct_seed_recommended: false
    )
    pepper_seed = SeedDefaultData.create!(
      plant_type: "Pepper",
      days_to_maturity: 64,
      seedling_days_to_transplant: 49,
      days_relative_to_frost_date: 14,
      direct_seed_recommended: false
    )
    eggplant_seed = SeedDefaultData.create!(
      plant_type: "Eggplant",
      days_to_maturity: 68,
      seedling_days_to_transplant: 49,
      days_relative_to_frost_date: 14,
      direct_seed_recommended: false
    )
    radish_seed = SeedDefaultData.create(
      plant_type: "Radish",
      days_to_maturity: 30,
      seedling_days_to_transplant: 0,
      days_relative_to_frost_date: -60,
      direct_seed_recommended: true
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
    plant_type: "Tomato",
    name: "Sungold",
    days_relative_to_frost_date: 14,
    days_to_maturity: 54,
    hybrid_status: 1,
    organic: false
  ) }

  let(:plant2_object) { user.plants.create!(
    plant_type: "Pepper",
    name: "Jalafuego",
    days_relative_to_frost_date: 14,
    days_to_maturity: 65,
    hybrid_status: 1,
    organic: false
  ) }

  let(:plant3_object) { user.plants.create!(
    plant_type: "Basil",
    name: "Thai Towers",
    days_relative_to_frost_date: 0,
    days_to_maturity: 40,
    hybrid_status: 1,
    organic: true
  ) }

  describe 'POST garden plants' do
    context 'starting a plant from seed' do
      context 'outside' do
        context 'right now' do
          it 'creates a garden plant that already has an updated planting status' do
            post '/api/v1/garden_plants', params: {
              plant_id: plant1_object.id,
              start_from_seed: true,
              seed_sew_type: :direct,
              actual_seed_sewing_date: Date.today,
              plant_type: "Tomato",
              name: "Sungold",
              days_relative_to_frost_date: 14,
              days_to_maturity: 54
            }

            result = JSON.parse(response.body, symbolize_names: true)

            expect(response).to be_successful

            expect(result[:data][:attributes][:planting_status]).to eq("direct_sewn_outside")
          end

          it 'provides an expected date range that the plant will be in a period of harvest' do
            post '/api/v1/garden_plants', params: {
              plant_id: plant1_object.id,
              start_from_seed: true,
              seed_sew_type: :direct,
              actual_seed_sewing_date: Date.today,
              plant_type: "Tomato",
              name: "Sungold",
              days_relative_to_frost_date: 14,
              days_to_maturity: 54
            }

            result = JSON.parse(response.body, symbolize_names: true)

            expect(response).to be_successful

            transplant_date = result[:data][:attributes][:recommended_transplant_date].to_date
            days_to_maturity = result[:data][:attributes][:days_to_maturity].to_i

            harvest_start = transplant_date + days_to_maturity
            harvest_finish = user.fall_frost_dates.to_date

            expect(result[:data][:attributes][:harvest_start].to_date).to eq(harvest_start)
            expect(result[:data][:attributes][:harvest_finish].to_date).to eq(harvest_finish)
          end

          xit 'provides a harvest range that is shorter for limited-harvest plants' do
            post '/api/v1/garden_plants', params: {
              plant_id: plant3_object.id,
              start_from_seed: true,
              seed_sew_type: :direct,
              actual_seed_sewing_date: Date.today,
              plant_type: "Basil",
              name: "Basil"
            }

            result = JSON.parse(response.body, symbolize_names: true)

            expect(response).to be_successful

            transplant_date = result[:data][:attributes][:recommended_transplant_date].to_date
            days_to_maturity = result[:data][:attributes][:days_to_maturity].to_i

            harvest_start = transplant_date + days_to_maturity
            harvest_finish = harvest_date + 21

            expect(result[:data][:attributes][:harvest_start]).to eq(harvest_start)
            expect(result[:data][:attributes][:harvest_finish]).to eq(harvest_finish)
          end
        end

        context 'in the future' do
          it 'creates a garden plant that has the information needed to be planted later' do
            post '/api/v1/garden_plants', params: {
              plant_id: plant1_object.id,
              start_from_seed: true,
              seed_sew_type: :direct,
              plant_type: "Tomato",
              name: "Sungold",
              days_relative_to_frost_date: 14,
              days_to_maturity: 54
            }

            result = JSON.parse(response.body, symbolize_names: true)

            expect(response).to be_successful

            expect(result[:data][:attributes][:planting_status]).to eq("not_started")
            expect(result[:data][:attributes][:recommended_transplant_date]).to_not be nil
            expect(result[:data][:attributes][:recommended_seed_sewing_date]).to eq(result[:data][:attributes][:recommended_transplant_date])
          end
        end
      end

      context 'inside' do
        context 'right now' do
          it 'creates new plant that the user will be planting' do
            post '/api/v1/garden_plants', params: {
              plant_id: plant1_object.id,
              start_from_seed: true,
              seed_sew_type: :indirect,
              actual_seed_sewing_date: Date.today,

              plant_type: "Tomato",
              name: "Sungold",
              days_relative_to_frost_date: 14,
              days_to_maturity: 54
              }

            result = JSON.parse(response.body, symbolize_names: true)
            new_plant = GardenPlant.last

            expect(response).to be_successful

            expect(new_plant.id).to eq(result[:data][:id].to_i)

            expect(result).to be_a Hash
            expect(result).to have_key(:data)

            expect(result[:data]).to be_a Hash
            expect(result[:data][:attributes][:name]).to eq(new_plant.name)
            
            expect(result[:data][:attributes][:planting_status]).to eq("started_indoors")

            expect(result[:data][:attributes]).to have_key(:name)
            expect(result[:data][:attributes]).to have_key(:plant_type)
            expect(result[:data][:attributes]).to have_key(:days_relative_to_frost_date)
            expect(result[:data][:attributes]).to have_key(:recommended_transplant_date)
            expect(result[:data][:attributes]).to have_key(:days_to_maturity)
            expect(result[:data][:attributes]).to have_key(:hybrid_status)
            expect(result[:data][:attributes]).to have_key(:organic)
            expect(result[:data][:attributes]).to have_key(:planting_status)
            expect(result[:data][:attributes]).to have_key(:start_from_seed)
            expect(result[:data][:attributes]).to have_key(:direct_seed_recommended)
            expect(result[:data][:attributes]).to have_key(:recommended_seed_sewing_date)
            expect(result[:data][:attributes]).to have_key(:actual_seed_sewing_date)
            expect(result[:data][:attributes]).to have_key(:seedling_days_to_transplant)
          end
          #likely to delete
          it 'will return a json error message if there was a problem' do
            post '/api/v1/garden_plants', params: { plant_id: 99999999999}

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
              start_from_seed: true,
              seed_sew_type: :indirect,

              plant_type: "Tomato",
              name: "Sungold",
              days_relative_to_frost_date: 14,
              days_to_maturity: 54
              }

              result = JSON.parse(response.body, symbolize_names: true)

              expect(result[:data][:attributes][:planting_status]).to eq("not_started")
              expect(result[:data][:attributes][:recommended_seed_sewing_date].to_date).to be_a Date
              expect(result[:data][:attributes][:seed_sew_type]).to eq("indirect")
              expect(result[:data][:attributes][:recommended_transplant_date].to_date).to be_a Date
          end
        end
      end
    end

    context 'starting as a plant' do
      context 'right now' do
        it 'creates a garden plant that is updated with information relevant to being place outside' do
          post '/api/v1/garden_plants', params: {
            plant_id: plant2_object.id,
            # This...
            actual_transplant_date: Date.today,
            # and this...should be enough to indicate the plant is transplanted outside.
            start_from_seed: false,
            plant_type: "Pepper",
            name: "Jalafuego",
            days_relative_to_frost_date: 14,
            days_to_maturity: 55
          }
          
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:data][:attributes][:planting_status]).to eq("transplanted_outside")
          expect(result[:data][:attributes][:hybrid_status]).to eq("unknown")
          expect(result[:data][:attributes][:start_from_seed]).to eq(false)
          expect(result[:data][:attributes][:seed_sew_type]).to eq("not_applicable")
          expect(result[:data][:attributes][:actual_seed_sewing_date]).to be nil
          expect(result[:data][:attributes][:recommended_seed_sewing_date].to_date).to be_a Date
          expect(result[:data][:attributes][:direct_seed_recommended]).to_not be nil
        end
      end

      context 'in the future' do
        it 'creates a garden plant that is scheduled with a planting in the future' do
          post '/api/v1/garden_plants', params: {
            plant_id: plant2_object.id,
            start_from_seed: false,
            plant_type: "Pepper",
            name: "Jalafuego",
            days_relative_to_frost_date: 14,
            days_to_maturity: 55
          }
          
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:data][:attributes][:planting_status]).to eq("not_started")
          expect(result[:data][:attributes][:start_from_seed]).to eq(false)
          expect(result[:data][:attributes][:seed_sew_type]).to eq("not_applicable")
          expect(result[:data][:attributes][:actual_seed_sewing_date]).to be nil
          expect(result[:data][:attributes][:recommended_seed_sewing_date]).to be nil
        end
      end
    end
  end

  describe 'GET /garden_plants' do
    it 'retrieves an array of the plants that belong to the user' do
      unused_plant = user.plants.create!(
        plant_type: "Something else",
        name: "A plant you shouldn't see",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: 1,
        organic: false
      )
      user.garden_plants.create!(
        {
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: 1,
        organic: false,
        seed_sew_type: :indirect,
        planting_status: "not_started",
        start_from_seed: true
        }
      )
      user.garden_plants.create!(
        {
        plant_type: "Pepper",
        name: "Jalafuego",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: 1,
        organic: false,
        seed_sew_type: :indirect,
        planting_status: "not_started",
        start_from_seed: true
        }
      )

      get '/api/v1/garden_plants'
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a Hash
      expect(result[:data]).to be_an Array

      # This makes sure the 'unused_plant' variable above is intentionally excluded
      expect(result[:data].count).to eq(2)

      result[:data].each do |plant|
        expect(plant[:attributes][:plant_type]).to be_a String
        expect(plant[:attributes][:name]).to be_a String
        expect(plant[:attributes][:days_relative_to_frost_date]).to be_an Integer
        expect(plant[:attributes][:days_to_maturity]).to be_an Integer
        expect(plant[:attributes][:hybrid_status]).to eq("f1").or eq("open_pollinated")
      end
    end
  end

  describe 'PATCH /garden_plants' do
    context 'when updating a GardenPlants planting status' do
      describe 'from not started to started indoors' do
        it 'returns will update the planting status and the seed-sewing date' do
          post '/api/v1/garden_plants', params: {
            plant_id: plant1_object.id,
            plant_type: "Tomato",
            name: "Sungold",
            days_relative_to_frost_date: 14,
            days_to_maturity: 54,
            hybrid_status: :open_pollinated,
            organic: false,
            start_from_seed: true,
            actual_seed_sewing_date: nil,
            seed_sew_type: :indirect,
            planting_status: "not_started"
          }

          new_garden_plant = GardenPlant.last

          patch "/api/v1/garden_plants/#{new_garden_plant.id}", params: {
            planting_status: "started_indoors",
            actual_seed_sewing_date: Date.today
          }
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:data][:attributes][:planting_status]).to eq("started_indoors")
          expect(result[:data][:attributes][:actual_seed_sewing_date]).to_not be nil
          expect(result[:data][:attributes][:actual_seed_sewing_date].to_date).to eq(Date.today)
        end

        it 'returns a meaningful error response if the frontend doesnt provide...' do
          post '/api/v1/garden_plants', params: {
            plant_id: plant1_object.id,
            plant_type: "Tomato",
            name: "Sungold",
            days_relative_to_frost_date: 14,
            days_to_maturity: 54,
            hybrid_status: :open_pollinated,
            organic: false,
            start_from_seed: true,
            actual_seed_sewing_date: nil,
            seed_sew_type: :indirect,
            planting_status: :not_started
          }

          new_garden_plant = GardenPlant.last

          patch "/api/v1/garden_plants/#{new_garden_plant.id}", params: {
            planting_status: :started_indoors
          }
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:error]).to eq("You must specify a seed-sewing date!")
        end
      end

      describe 'from Started Indoors to Transplanted Outside' do
        it 'will update the planting status and the actual transplant date' do
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
            planting_status: :started_indoors
          }

          new_garden_plant = GardenPlant.last

          patch "/api/v1/garden_plants/#{new_garden_plant.id}", params: {
            planting_status: :transplanted_outside,
            actual_transplant_date: Date.today
          }
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:data][:attributes][:planting_status]).to eq("transplanted_outside")
          expect(result[:data][:attributes][:actual_transplant_date]).to_not be nil
          expect(result[:data][:attributes][:actual_transplant_date].to_date).to eq(Date.today)
        end

        it 'returns a meaningful error response if the frontend doesnt provide...' do
          post '/api/v1/garden_plants', params: {
            plant_id: plant1_object.id,
            plant_type: "Tomato",
            name: "Sungold",
            days_relative_to_frost_date: 14,
            days_to_maturity: 54,
            hybrid_status: :open_pollinated,
            organic: false,
            start_from_seed: true,
            actual_seed_sewing_date: nil,
            seed_sew_type: :indirect,
            planting_status: "not_started"
          }

          new_garden_plant = GardenPlant.last

          patch "/api/v1/garden_plants/#{new_garden_plant.id}", params: {
            planting_status: :transplanted_outside
          }
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:error]).to eq("You must specify a transplant date!")
        end
      end
      
      describe 'from not started to transplanted outside' do
        it 'will return a meaningful error response if the frontend doesnt provide an actual transplant date' do
          post '/api/v1/garden_plants', params: {
            plant_id: plant1_object.id,
            plant_type: "Tomato",
            name: "Sungold",
            days_relative_to_frost_date: 14,
            days_to_maturity: 54,
            hybrid_status: :open_pollinated,
            organic: false,
            start_from_seed: true,
            actual_seed_sewing_date: nil,
            seed_sew_type: :indirect,
            planting_status: "not_started"
          }

          new_garden_plant = GardenPlant.last

          patch "/api/v1/garden_plants/#{new_garden_plant.id}", params: {
            planting_status: "transplanted_outside"
          }
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:error]).to eq("You must specify a transplant date!")
        end

        it 'will only update the object when an actual_transplant_date is passed' do
          post '/api/v1/garden_plants', params: {
            plant_id: plant1_object.id,
            plant_type: "Tomato",
            name: "Sungold",
            days_relative_to_frost_date: 14,
            days_to_maturity: 54,
            hybrid_status: :open_pollinated,
            organic: false,
            start_from_seed: true,
            actual_seed_sewing_date: nil,
            seed_sew_type: :indirect,
            planting_status: "not_started"
          }

          new_garden_plant = GardenPlant.last

          patch "/api/v1/garden_plants/#{new_garden_plant.id}", params: {
            planting_status: "transplanted_outside", 
            actual_transplant_date: Date.today
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
            plant_type: "Radish",
            name: "French Breakfast",
            days_relative_to_frost_date: -45,
            days_to_maturity: 30,
            hybrid_status: :unknown,
            start_from_seed: true,
            actual_seed_sewing_date: nil,
            seed_sew_type: :direct,
            planting_status: "not_started"
          }

          new_garden_plant = GardenPlant.last

          patch "/api/v1/garden_plants/#{new_garden_plant.id}", params: {
            planting_status: "direct_sewn_outside", 
            actual_transplant_date: Date.today
          }
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:data][:attributes][:planting_status]).to eq("direct_sewn_outside")
          expect(result[:data][:attributes][:actual_transplant_date].to_date).to eq(Date.today)
          expect(result[:data][:attributes][:actual_seed_sewing_date]).to_not be nil
          expect(result[:data][:attributes][:actual_seed_sewing_date].to_date).to eq(Date.today)
        end

        it 'will return an error if the necessary information was not provided' do
          post '/api/v1/garden_plants', params: {
            plant_id: plant1_object.id,
            plant_type: "Radish",
            name: "French Breakfast",
            days_relative_to_frost_date: -45,
            days_to_maturity: 30,
            hybrid_status: :unknown,
            start_from_seed: true,
            actual_seed_sewing_date: nil,
            seed_sew_type: :direct,
            planting_status: "not_started"
          }

          new_garden_plant = GardenPlant.last

          patch "/api/v1/garden_plants/#{new_garden_plant.id}", params: {
            planting_status: "direct_sewn_outside"
          }
          result = JSON.parse(response.body, symbolize_names: true)
          
          expect(result[:error]).to eq("You must specify a transplant date!")
        end
      end
    end

    it 'allows the user to add an actual planting date to an existing garden_plant' do
      post '/api/v1/garden_plants', params: {
        plant_id: plant1_object.id,
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: :open_pollinated,
        organic: false,
        start_from_seed: true,
        actual_seed_sewing_date: nil,
        seed_sew_type: :indirect,
        planting_status: "not_started"
      }

      result = JSON.parse(response.body, symbolize_names: true)
      garden_plant = GardenPlant.last

      expect(response).to be_successful

      expect(garden_plant.id).to eq(result[:data][:id].to_i)

      expect(result).to be_a Hash
      expect(result).to have_key(:data)

      expect(result[:data]).to be_a Hash
      expect(result[:data][:attributes][:name]).to eq(garden_plant.name)

      expect(result[:data][:attributes]).to have_key(:name)
      expect(result[:data][:attributes]).to have_key(:plant_type)
      expect(result[:data][:attributes]).to have_key(:days_relative_to_frost_date)
      expect(result[:data][:attributes]).to have_key(:recommended_transplant_date)
      expect(result[:data][:attributes]).to have_key(:days_to_maturity)
      expect(result[:data][:attributes]).to have_key(:hybrid_status)
      expect(result[:data][:attributes]).to have_key(:organic)
      expect(result[:data][:attributes]).to have_key(:planting_status)
      expect(result[:data][:attributes][:planting_status]).to eq("not_started")

      expect(result[:data][:attributes]).to have_key(:start_from_seed)
      expect(result[:data][:attributes]).to have_key(:direct_seed_recommended)
      expect(result[:data][:attributes]).to have_key(:recommended_seed_sewing_date)
      expect(result[:data][:attributes]).to have_key(:actual_seed_sewing_date)
      expect(result[:data][:attributes]).to have_key(:seedling_days_to_transplant)

      patch "/api/v1/garden_plants/#{garden_plant.id}", params: {
        actual_seed_sewing_date: Date.yesterday
        }

      patch_result = JSON.parse(response.body, symbolize_names: true)

      expect(patch_result[:data][:attributes][:actual_seed_sewing_date].to_date).to eq(Date.yesterday)
      expect(patch_result[:data][:attributes][:recommended_transplant_date]).to eq((Date.yesterday + @tomato_seed.seedling_days_to_transplant).to_s)
    end

    it 'will add a transplant date to the garden_plant object when giving a plant a transplant date' do
      post '/api/v1/garden_plants', params: {
        plant_id: plant1_object.id,
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: :open_pollinated,
        organic: false,
        start_from_seed: true,
        actual_seed_sewing_date: Date.today,
        seed_sew_type: :indirect,
        planting_status: "started_indoors"
        }

      result = JSON.parse(response.body, symbolize_names: true)
      garden_plant = GardenPlant.last

      expect(response).to be_successful

      expect(garden_plant.id).to eq(result[:data][:id].to_i)

      expect(result).to be_a Hash
      expect(result).to have_key(:data)

      expect(result[:data]).to be_a Hash
      expect(result[:data][:attributes][:name]).to eq(garden_plant.name)

      expect(result[:data][:attributes]).to have_key(:name)
      expect(result[:data][:attributes]).to have_key(:plant_type)
      expect(result[:data][:attributes]).to have_key(:days_relative_to_frost_date)
      expect(result[:data][:attributes]).to have_key(:recommended_transplant_date)
      expect(result[:data][:attributes]).to have_key(:days_to_maturity)
      expect(result[:data][:attributes]).to have_key(:hybrid_status)
      expect(result[:data][:attributes]).to have_key(:organic)
      expect(result[:data][:attributes]).to have_key(:planting_status)
      expect(result[:data][:attributes][:planting_status]).to eq("started_indoors")

      patch "/api/v1/garden_plants/#{garden_plant.id}", params: { actual_transplant_date: Date.today }

      patch_result = JSON.parse(response.body, symbolize_names: true)

      expect(patch_result[:data][:attributes]).to have_key(:actual_transplant_date)
      expect(patch_result[:data][:attributes][:actual_transplant_date]).to eq(Date.today.to_s)
    end
  end

  describe 'DELETE /garden_plants' do
    it 'removes the plant from the users list of plants' do
      garden_plant = user.garden_plants.create!(
        {
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: 1,
        organic: false,
        seed_sew_type: :indirect,
        planting_status: "not_started",
        start_from_seed: true
        }
      )

      delete "/api/v1/garden_plants/#{garden_plant.id}"
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:status]).to eq("success")
    end
  end
end
