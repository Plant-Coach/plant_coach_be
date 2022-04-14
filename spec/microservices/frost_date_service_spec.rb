require 'rails_helper'

RSpec.describe FrostDateService do
  describe '::get_frost_dates' do
    it 'returns the spring and fall frost dates based on a users location' do
      zip_code = "80112"
      data = FrostDateService.get_frost_dates(zip_code)

      expect(data).to be_a Hash
      expect(data).to have_key(:data)

      expect(data[:data]).to be_an Array

      data[:data].each do |weather|
        expect(weather).to be_a Hash
        expect(weather).to have_key(:id)
        expect(weather).to have_key(:type)
        expect(weather).to have_key(:attributes)

        expect(weather[:attributes]).to be_a Hash
        expect(weather[:attributes]).to have_key(:date)
        expect(weather[:attributes]).to have_key(:sunrise)
        expect(weather[:attributes]).to have_key(:sunset)
        expect(weather[:attributes]).to have_key(:high)
        expect(weather[:attributes]).to have_key(:low)
        expect(weather[:attributes]).to have_key(:humidity)
        expect(weather[:attributes]).to have_key(:wind)
        expect(weather[:attributes]).to have_key(:weather)
      end
    end
  end
end
