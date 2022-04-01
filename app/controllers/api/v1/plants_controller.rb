class Api::V1::PlantsController < ApplicationController
  def create
    plant = Plant.create(plant_params)
    # require 'pry'; binding.pry
    if plant.save
      render json: PlantSerializer.new(plant), status: 201
    end
  end

  def update
    plant = Plant.update(plant_params)
    render json: PlantSerializer.new(plant), status: 200
  end

  def destroy
    plant = Plant.find_by(id: params[:id])
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
