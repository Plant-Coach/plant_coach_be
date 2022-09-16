class Api::V1::GardenPlantsController < ApplicationController
  def index
    # Access all of the garden plants for the authenticated user.
    garden_plants = @user.garden_plants
    render json: GardenPlantSerializer.new(garden_plants), status: 200
  end

  def create
    # Return the plant as an array so that an error is not thrown
    plant_result = Plant.find_by_id(params[:plant_id])
    garden_plant = @user.create_garden_plant(plant_result)
    require 'pry'; binding.pry




    # If this was successful, (and it always should be!), render the new entry.
    # if !plant_result.empty?
    #   # Now grab the plant object from the array since we know it exists.
    #   plant = plant_result.first
    #   # Move to a model.
    #   # Copy all of the plant into the new Garden Plant that the user will plant.
    #   garden_plant = @user.garden_plants.create(
    #     plant_type: plant.plant_type,
    #     name: plant.name,
    #     days_relative_to_frost_date: plant.days_relative_to_frost_date,
    #     days_to_maturity: plant.days_to_maturity,
    #     hybrid_status: plant.hybrid_status,
    #     organic: plant.organic
    #   )
      # Return the newly created GardenPlant object to the FE
      render json: GardenPlantSerializer.new(garden_plant)
    # else
      # Return a generic error, though this should never be able to happen due
      # to controls that happen before this.
      # render json: GardenPlantSerializer.error("There was a problem."), status: 400
    # end
  end

  # Destroying a GardenPlant object only means that the user is not planting it
  # in their garden.  Will still retain the plant as a Plant object.
  def destroy
    garden_plant = @user.garden_plants.where(id: params[:id]).first
    if !garden_plant.nil?
      result = GardenPlant.destroy(garden_plant.id)
      render json: GardenPlantSerializer.confirm, status: 200
    end
  end
end
