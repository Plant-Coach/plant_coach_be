class Api::V1::UserPlantsController < ApplicationController
  def create
    user_plant = UserPlant.create(
      user_id: params[:user_id],
      plant_id: params[:plant_id]
    )
    require 'pry'; binding.pry
    if user_plant.save
      user = User.find(params[:user_id])
      plant = Plant.find(params[:plant_id])
      render json: UserPlantSerializer.format(user, plant)
    else
      render json: UserPlantSerializer.error("There was a problem."), status: 400
    end
  end

  def destroy
    user_plant = UserPlant.find(params[:id])
    if user_plant != nil
      result = UserPlant.destroy(user_plant.id)
      render json: UserPlantSerializer.new(result), status: 200
    end
  end
end
