class Api::V1::UserPlantsController < ApplicationController
  def index
    user_plants = @user.find_users_plants
    render json: PlantSerializer.new(user_plants), status: 200
  end

  def create
    user_plant = UserPlant.create(
      user_id: @user.id,
      plant_id: params[:plant_id]
    )

    if user_plant.save
      plant = Plant.find(params[:plant_id])
      render json: UserPlantSerializer.new(plant)
    else
      render json: UserPlantSerializer.error("There was a problem."), status: 400
    end
  end

  def destroy
    user_plant = @user.find_user_plant_by_plant_id(params[:id])
    if user_plant != nil
      result = UserPlant.destroy(user_plant.id)
      render json: UserPlantSerializer.confirm, status: 200
    end
  end
end
