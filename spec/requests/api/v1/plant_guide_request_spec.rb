require 'rails_helper'

RSpec.describe '/plant_guides API Endpoint', :vcr do
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
    @raspberry_guide = @user.plant_guides.create(
      plant_type: "Raspberry",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: false,
      days_to_maturity: 100,
      days_relative_to_frost_date: 0,
      harvest_period: "season_long"
    )
  end

  describe 'GET /plant_guides' do
    it 'gets a list of all of the plant guides that belong to that user' do
      get '/api/v1/plant_guides', headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }
      result = JSON.parse(response.body, symbolize_names:true)

      expect(response).to be_successful

      expect(result[:plant_guides]).to be_an Array

      plant_types = [
        "Tomato", "Pepper", "Eggplant", "Romaine Lettuce", "Green Bean", 
        "Radish", "Carrot", "Sprouting Broccoli", "Basil", "Cilantro", "Raspberry"
      ]
      
      expect(result[:plant_guides].count).to eq(11)

      result[:plant_guides].each do |guide|
        expect(guide[:id]).to be_an Integer
        expect(plant_types).to include(guide[:plant_type])
      end
    end
  end

  describe 'POST /plant_guides' do
    it 'creates a new plant guide that only belongs to that user' do
      plant_params = {
        plant_type: "Watermelon",
        direct_seed_recommended: false,
        seedling_days_to_transplant: 45,
        days_to_maturity: 50,
        days_relative_to_frost_date: 14,
        harvest_period: :one_time
      }

      post '/api/v1/plant_guides', params: plant_params, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:attributes][:plant_type]).to eq("Watermelon")
    end

    it 'returns an informative error if the Plant Type is missing' do
      plant_params_with_missing_data = {
        plant_type: "",
        direct_seed_recommended: false,
        seedling_days_to_transplant: 60,
        days_to_maturity: 30,
        days_relative_to_frost_date: 14,
        harvest_period: :one_time
      }

      post '/api/v1/plant_guides', params: plant_params_with_missing_data, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:errors]).to include("A Plant Type must be provided.")
    end

    it 'returns an informative error if Days to Maturity is missing' do
      plant_params_with_missing_data = {
        plant_type: "Watermelon",
        direct_seed_recommended: false,
        seedling_days_to_transplant: 60,
        # days_to_maturity: 30,
        days_relative_to_frost_date: 14,
        harvest_period: :one_time
      }

      post '/api/v1/plant_guides', params: plant_params_with_missing_data, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:errors]).to include("Days to Maturity can not be blank.")
    end

    it 'returns an informative error if Days Relative to Frost Date is missing' do
      plant_params_with_missing_data = {
        plant_type: "Watermelon",
        direct_seed_recommended: false,
        seedling_days_to_transplant: 60,
        days_to_maturity: 30,
        # days_relative_to_frost_date: 14,
        harvest_period: :one_time
      }

      post '/api/v1/plant_guides', params: plant_params_with_missing_data, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:errors]).to include("Days Relative to Frost Date must not be blank.")
    end

    it 'returns an informative error if Harvest Period is not provided' do
      plant_params_with_missing_data = {
        plant_type: "Watermelon",
        direct_seed_recommended: false,
        seedling_days_to_transplant: 60,
        days_to_maturity: 30,
        days_relative_to_frost_date: 14
        # harvest_period: :one_time
      }

      post '/api/v1/plant_guides', params: plant_params_with_missing_data, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:errors]).to include("Harvest Period must not be blank.")
    end

    it 'only accepts integer values for seedling_days_to_transplant' do
      plant_params_with_missing_data = {
        plant_type: "Watermelon",
        direct_seed_recommended: false,
        seedling_days_to_transplant: "This should be an Integer",
        days_to_maturity: 30,
        days_relative_to_frost_date: 14,
        harvest_period: :one_time
      }

      post '/api/v1/plant_guides', params: plant_params_with_missing_data, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:errors]).to include("Seedling Days to Transplant must be a whole number.")
    end

    it 'only accepts integer values for days_to_maturity' do
      plant_params_with_missing_data = {
        plant_type: "Watermelon",
        direct_seed_recommended: false,
        seedling_days_to_transplant: 50,
        days_to_maturity: "This should be an Integer",
        days_relative_to_frost_date: 14,
        harvest_period: :one_time
      }

      post '/api/v1/plant_guides', params: plant_params_with_missing_data, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:errors]).to include("Days to Maturity must be a whole number.")
    end

    it 'only accepts integer values for days_relative_to_frost_date' do
      plant_params_with_missing_data = {
        plant_type: "Watermelon",
        direct_seed_recommended: false,
        seedling_days_to_transplant: 14,
        days_to_maturity: 80,
        days_relative_to_frost_date: "This should be an Integer",
        harvest_period: :one_time
      }

      post '/api/v1/plant_guides', params: plant_params_with_missing_data, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:errors]).to include("Days Relative to Frost Date must be a whole number.")
    end

    it 'can give error feedback about multiple incorrect values' do
      plant_params_with_missing_data = {
        plant_type: "Watermelon",
        direct_seed_recommended: false,
        seedling_days_to_transplant: "This should be an Integer",
        days_to_maturity: "This should be an Integer",
        days_relative_to_frost_date: "This should be an Integer",
        harvest_period: :one_time
      }

      post '/api/v1/plant_guides', params: plant_params_with_missing_data, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:errors][0]).to include("Seedling Days to Transplant must be a whole number.")
      expect(result[:errors][1]).to include("Days to Maturity must be a whole number.")
      expect(result[:errors][2]).to include("Days Relative to Frost Date must be a whole number.")
    end

    it 'only allows one plant guide per plant type, per user' do
      plant_params_with_missing_data = {
        plant_type: "Watermelon",
        direct_seed_recommended: false,
        seedling_days_to_transplant: 0,
        days_to_maturity: 75,
        days_relative_to_frost_date: 14,
        harvest_period: :one_time
      }

      post '/api/v1/plant_guides', params: plant_params_with_missing_data, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      result = JSON.parse(response.body, symbolize_names: true)

      plant_params_with_missing_data = {
        plant_type: "Watermelon",
        direct_seed_recommended: false,
        seedling_days_to_transplant: 0,
        days_to_maturity: 75,
        days_relative_to_frost_date: 14,
        harvest_period: :one_time
      }

      post '/api/v1/plant_guides', params: plant_params_with_missing_data, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      result1 = JSON.parse(response.body, symbolize_names: true)

      expect(result1[:errors]).to include("A Plant Guide for Watermelons already exists for Joel Grant!")
    end

  end

  describe 'PATCH /plant_guides' do
    it 'modifies an existing plant guide that only belongs to that user' do
      patch "/api/v1/plant_guides/#{@tomato_guide.id}", params: { days_to_maturity: 55 }, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      expect(response).to be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:attributes][:days_to_maturity]).to eq(55)
    end

    it 'returns an informative error response when any values are missing during an update' do
      patch "/api/v1/plant_guides/#{@tomato_guide.id}", params: { harvest_period: "" }, headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      expect(response).to_not be_successful

      result = JSON.parse(response.body, symbolize_names: true)
      
      expect(result[:errors]).to include("Harvest Period must not be blank.")
    end
  end

  describe 'DELETE /plant_guides' do
    it "removes a plant guide from only that user's list of plant guides" do
      delete "/api/v1/plant_guides/#{@raspberry_guide.id}", headers: {
        Authorization: "Bearer #{@user_response[:jwt]}"
      }

      expect(response).to be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:status]).to eq("success")
    end
  end
end
