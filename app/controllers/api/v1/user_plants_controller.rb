class Api::V1::UserPlantsController < ApplicationController
  def create
    user_plant = UserPlant.create(user_id: params[:user_id], plant_id: params[:plant_id])
    if user_plant.save
      user = User.find(params[:user_id])
      plant = Plant.find(params[:plant_id])
      render json: UserPlantSerializer.format(user, plant)
    else
      render json: UserPlantSerializer.error("There was a problem."), status: 400
    end
  end
end
