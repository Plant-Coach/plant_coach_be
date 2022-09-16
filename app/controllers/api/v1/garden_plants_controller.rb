class Api::V1::GardenPlantsController < ApplicationController
  def index
    # Access all of the garden plants for the authenticated user.
    garden_plants = @user.garden_plants
    render json: GardenPlantSerializer.new(garden_plants), status: 200
  end

  def create
    plant_result = Plant.find_by_id(params[:plant_id])
    garden_plant = @user.create_garden_plant(plant_result)
    render json: GardenPlantSerializer.new(garden_plant)
  end

  def destroy
    garden_plant = @user.garden_plants.where(id: params[:id]).first
    if !garden_plant.nil?
      result = GardenPlant.destroy(garden_plant.id)
      render json: GardenPlantSerializer.confirm, status: 200
    end
  end
end
