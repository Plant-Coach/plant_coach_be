# CRUD for the plants a User has added to their garden for the year.
class Api::V1::GardenPlantsController < ApplicationController
  def index
    # Access all of the garden plants for the authenticated user.
    garden_plants = @user.garden_plants
    render json: GardenPlantSerializer.new(garden_plants), status: :ok
  end

  def create
    plant = @user.plants.find_by!(id: params[:plant_id])
    new_garden_plant = plant.garden_plants.create(garden_plant_params)
    render json: GardenPlantSerializer.new(new_garden_plant)
  rescue ActiveRecord::RecordNotFound
    render json: GardenPlantSerializer.error(
      'There was a problem finding a plant to copy!'
    ), status: :bad_request
  end

  def update
    garden_plant = @user.garden_plants.find_by(id: params[:id])
    garden_plant.update!(garden_plant_params)
    render json: GardenPlantSerializer.new(garden_plant)
  rescue ActiveRecord::RecordInvalid
    render json: GardenPlantSerializer.errors(garden_plant.errors.full_messages)
  end

  def destroy
    garden_plant = @user.garden_plants.find_by_id!(params[:id])
    GardenPlant.destroy(garden_plant.id)
    render json: GardenPlantSerializer.confirm, status: :ok
  rescue ActiveRecord::RecordNotFound
    Logger::Error 'Record could not be found and could not be destroyed.'
    render json: PlantSerializer.single_error('The record could not be found for deletion!'), status: :bad_request
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
