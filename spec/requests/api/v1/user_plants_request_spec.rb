require 'rails_helper'

RSpec.describe 'User Plants API Endpoint' do
  describe 'POST user plants' do
    it 'creates new plant that the user will be planting' do
      plant = Plant.create!(plant_type: "Tomato", name: "Sungold", days_relative_to_frost_date: 14, days_to_maturity: 54, hybrid_status: 1)
      user = User.create!(name: "Joel User", email: 'joel@123.com', password: "12345")

      post '/api/v1/user_plants', params: { user_id: user.id, plant_id: plant}
      require 'pry'; binding.pry
      new_plant = UserPlant.last

    end
  end
end
