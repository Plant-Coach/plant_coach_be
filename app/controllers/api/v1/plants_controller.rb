class Api::V1::PlantsController < ApplicationController
  # Returns the list of plants that a user has in their personal database.
  def index
    plants = @user.plants
    render json: PlantSerializer.new(plants), status: :accepted
  end
  # Allows a user to add a new plant to their personal database of plants.
  def create
    plant = @user.plants.create(plant_params)
    # If all of the information was provided to create a plant record...
    if plant.save
      render json: PlantSerializer.new(plant), status: 201
    else
      render json: PlantSerializer.error("The plant could not be saved!"), status: 403
    end
  end
  # Allows a plant record to be edited by the user.
  def update
    plant = Plant.find(params[:id])
    updated_plant = plant.update(plant_params)
    render json: PlantSerializer.new(plant), status: 200
  end
  # Allows the user to delete the plant record.
  def destroy
    plant = Plant.find_by(id: params[:id])
    # If the plant record is found...
    if !plant.nil?
      deleted_plant = plant.destroy
      render json: PlantSerializer.new(deleted_plant), status: 200
    else
      render json: PlantSerializer.error("Something happened!"), status: 400
    end
  end

  private
  def plant_params
    params.permit(
      :plant_type,
      :name,
      :days_relative_to_frost_date,
      :days_to_maturity,
      :hybrid_status
    )
  end
end
