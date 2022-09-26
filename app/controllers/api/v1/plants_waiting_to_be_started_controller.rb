class Api::V1::PlantsWaitingToBeStartedController < ApplicationController
  def index
    plants_not_yet_started = @user.plants_waiting_to_be_started
    render json: PlantsWaitingToBeStartedSerializer.new(plants_not_yet_started)
  end
end
