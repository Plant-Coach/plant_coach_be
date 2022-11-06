class Api::V1::GardenPlantsController < ApplicationController
  def index
    # Access all of the garden plants for the authenticated user.
    garden_plants = @user.garden_plants
    render json: GardenPlantSerializer.new(garden_plants), status: 200
  end

  def create
    plant_result = Plant.find_by_id(params[:plant_id])
    if plant_result.nil?
      render json: GardenPlantSerializer.error("There was a problem finding a plant to copy!"), status: 400
    else
      garden_plant = @user.create_garden_plant(plant_result, params[:start_from_seed], params[:sewing_date])
      render json: GardenPlantSerializer.new(garden_plant)
    end
  end

  def update
    garden_plant = @user.garden_plants.find_by(id: params[:id])
    result = garden_plant.update(garden_plant_params)
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

private

def garden_plant_params
  params.permit(
    :actual_seed_sewing_date,
    :name,
    :days_to_maturity,
    :actual_transplant_date
  )
end
