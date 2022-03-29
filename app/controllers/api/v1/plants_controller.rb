class Api::V1::PlantsController < ApplicationController
  def create
    plant = Plant.create(plant_params)
    if plant.save
      render json: PlantSerializer.new(plant), status: 201
    end
  end

  def update
    plant = Plant.update(plant_params)
    render json: PlantSerializer.new(plant), status: 200
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
