require 'rails_helper'

RSpec.describe ForecastFacade do
  describe '::get_forecast' do
    it 'returns the forecast from the service' do
      data = ForecastFacade.get_forecast("80112")
      
    end
  end
end
