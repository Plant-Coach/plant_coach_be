require 'rails_helper'

RSpec.describe FrostDateService, :vcr do
  describe '::get_frost_dates' do
    it 'returns the spring and fall frost dates based on a users location' do
      zip_code = "80112"
      data = FrostDateService.get_frost_dates(zip_code)

      expect(data).to be_a Hash
      expect(data).to have_key(:data)

      expect(data[:data]).to be_an Hash

    end
  end
end
