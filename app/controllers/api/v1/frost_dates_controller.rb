class Api::V1::FrostDatesController < ApplicationController
  def index
    frost_data = FrostDateFacade.get_frost_dates(@user.zip_code)
    render json: FrostDateSerializer.new(frost_data)
  end
end
