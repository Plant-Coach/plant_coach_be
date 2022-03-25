require 'rails_helper'

RSpec.describe Forecast do
  describe 'forecast' do
    it 'exists' do
      forecast = Forecast.new
      expect(forecast).to be_a Forecast
    end
  end
end
