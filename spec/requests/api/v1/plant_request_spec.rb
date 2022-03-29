require 'rails_helper'

RSpec.describe 'Plant API Endpoints' do
  describe 'POST /plants' do
    it 'creates a new plant in the database' do
      plant = {plant_type: "Tomato", name: "Sungold", days_relative_to_frost_date: 14, days_to_maturity: 54, hybrid_status: 1}
      post '/api/v1/plants', params: plant
      result = JSON.parse(response.body, symbolize_names: true)
    end
  end

  describe 'PATCH /plants' do
    it 'updates an existing plant with new attributes' do
      plant = Plant.create(plant_type: "Tomato", name: "Sungold", days_relative_to_frost_date: 14, days_to_maturity: 54, hybrid_status: 1)
      patch "/api/v1/plants/#{plant.id}", params: { days_to_maturity: 61 }
      result = JSON.parse(response.body, symbolize_names: true)
      
      expect(result[:data][0][:attributes][:days_to_maturity]).to eq(61)
    end
  end
end
