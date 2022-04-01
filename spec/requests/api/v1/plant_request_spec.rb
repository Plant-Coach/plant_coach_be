require 'rails_helper'

RSpec.describe 'Plant API Endpoints' do
  describe 'POST /plants' do
    it 'creates a new plant in the database' do
      body = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      plant = {
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: 1}
      post '/api/v1/plants', params: plant, headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(result).to be_a Hash
      expect(result[:data][:attributes][:name]).to eq("Sungold")
    end
  end

  describe 'PATCH /plants' do
    it 'updates an existing plant with new attributes' do
      body = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      plant = Plant.create(
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: 1)
      patch "/api/v1/plants/#{plant.id}", params: {
        days_to_maturity: 61
        }, headers: {
          Authorization: "Bearer #{user_response[:jwt]}"
        }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][0][:attributes][:days_to_maturity]).to eq(61)
    end
  end

  describe 'DELETE /plants' do
    it 'removes a plant from the list of available plants' do
      body = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      plant1 = Plant.create(
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: 1
      )
      plant2 = Plant.create(
        plant_type: "Pepper",
        name: "Jalafuego",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: 1
      )
      plant3 = Plant.create(
        plant_type: "Radish",
        name: "French Breakfast",
        days_relative_to_frost_date: 30,
        days_to_maturity: 21,
        hybrid_status: 1
      )

      delete "/api/v1/plants/#{plant3.id}", headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(Plant.find_by(id: plant3.id)).to be nil
    end

    it 'returns an error if the plant cant be found' do
      body = {
        name: 'Joel Grant',
        email: 'joel@plantcoach.com',
        zip_code: '80121',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: body
      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      plant1 = Plant.create(
        plant_type: "Tomato",
        name: "Sungold",
        days_relative_to_frost_date: 14,
        days_to_maturity: 54,
        hybrid_status: 1
      )
      plant2 = Plant.create(
        plant_type: "Pepper",
        name: "Jalafuego",
        days_relative_to_frost_date: 14,
        days_to_maturity: 65,
        hybrid_status: 1
      )
      plant3 = Plant.create(
        plant_type: "Radish",
        name: "French Breakfast",
        days_relative_to_frost_date: 30,
        days_to_maturity: 21,
        hybrid_status: 1
      )
      delete "/api/v1/plants/999999", headers: {
        Authorization: "Bearer #{user_response[:jwt]}"
      }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:error]).to eq("Something happened!")
    end
  end
end
