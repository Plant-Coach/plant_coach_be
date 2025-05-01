class Api::V1::GardenPlantsController < ApplicationController
  def index
    # Access all of the garden plants for the authenticated user.
    garden_plants = @user.garden_plants
    render json: GardenPlantSerializer.new(garden_plants), status: :ok
  end

  def create
    plant = @user.plants.find_by(id: params[:plant_id])
    if plant.nil?
      render json: GardenPlantSerializer.error(
        'There was a problem finding a plant to copy!'
      ), status: :bad_request
    else
      new_garden_plant = plant.garden_plants.create(garden_plant_params)
      render json: GardenPlantSerializer.new(new_garden_plant)
    end
  end

  def update
    garden_plant = @user.garden_plants.find_by(id: params[:id])
    garden_plant.update(garden_plant_params)

    if garden_plant.valid?
      render json: GardenPlantSerializer.new(garden_plant)
    elsif !garden_plant.errors[:actual_transplant_date].empty?
      render json: GardenPlantSerializer.error(garden_plant.errors[:actual_transplant_date].first)
    elsif !garden_plant.errors[:actual_seed_sewing_date].empty?
      render json: GardenPlantSerializer.error(garden_plant.errors[:actual_seed_sewing_date].first)
    end
  end

  def destroy
    garden_plant = @user.garden_plants.where(id: params[:id]).first
    return if garden_plant.nil?

    GardenPlant.destroy(garden_plant.id)
    render json: GardenPlantSerializer.confirm, status: :ok
  end
end

private

def garden_plant_params
  params.permit(
    :actual_seed_sewing_date,
    :actual_transplant_date,
    :plant_start_method, # Used for create.
    :planting_status
  )
end
