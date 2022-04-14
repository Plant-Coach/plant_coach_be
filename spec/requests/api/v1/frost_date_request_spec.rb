require 'rails_helper'

RSpec.describe 'Frost Date API Endpoint' do
  describe 'GET /frost_data' do
    it 'returns the the spring and fall frost dates in addition to more details location data' do
      user_zip_code = { zip_code: 80124 }
      get '/api/v1/frost_dates', params: user_zip_code
      result = JSON.parse(response.body, symbolize_names: true)
      require 'pry'; binding.pry
    end
  end
end
