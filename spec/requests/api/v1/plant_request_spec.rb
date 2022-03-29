require 'rails_helper'

RSpec.describe 'Plant API Endpoints' do
  describe 'POST /plants' do
    it 'creates a new plant in the database' do
      plant = {plant_type: "Tomato", name: "Sungold", days_relative_to_frost_date: 14, days_to_maturity: 54, hybrid_status: 1}
      post '/api/v1/plants', params: plant
      result = JSON.parse(response.body, symbolize_names: true)

    end
  end
end
