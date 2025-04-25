class Api::V1::PlantsController < ApplicationController
  # Returns the list of plants that a user has in their personal database.
  def index
    plants = @user.plants
    render json: PlantSerializer.new(plants), status: :accepted
  end

  def create
    plant = @user.plants.create(plant_params)
    if plant.save
      render json: PlantSerializer.new(plant), status: :created
    else
      render json: PlantSerializer.errors(plant.errors.full_messages), status: :forbidden
    end
  end

  def show
    users_plant = @user.plants.find_by_id(params[:id])
    if users_plant
      render json: PlantSerializer.new(users_plant), status: :ok
    else
      render json: PlantSerializer.single_error('The plant can not be found!'), status: :bad_request
    end
  end

  def update
    plant = @user.plants.find_by(id: params[:id])
    plant.update(plant_params)
    render json: PlantSerializer.new(plant), status: :ok
  end

  def destroy
    plant = @user.plants.find_by(id: params[:id])
    if !plant.nil?
      deleted_plant = plant.destroy
      render json: PlantSerializer.new(deleted_plant), status: :ok
    else
      render json: PlantSerializer.single_error('Something happened!'), status: :bad_request
    end
  end

  private

  def plant_params
    params.permit(
      :plant_type,
      :name,
      :days_relative_to_frost_date,
      :days_to_maturity,
      :hybrid_status,
      :harvest_period,
      :organic
    )
  end
end
