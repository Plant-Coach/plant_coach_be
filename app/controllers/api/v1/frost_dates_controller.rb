class Api::V1::FrostDatesController < ApplicationController
  def index
    # Returns a FrostDate Object with location and frost dates
    frost_data = FrostDateFacade.get_frost_dates(@user.zip_code)
    render json: FrostDateSerializer.new(frost_data)
  end
end
